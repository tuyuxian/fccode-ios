//
//  VoiceMessageEditSheetViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/7/23.
//

import Foundation
import AVFoundation
import GraphQLAPI
import SwiftUI
import DSWaveformImage

class VoiceMessageEditSheetViewModel: ObservableObject {
    
    /// Audio permission manager
    let audioPermissionManager = AudioPermissionManager()
    
    /// User data
    @AppStorage("UserId") private var userId: String = ""
    @Published var hasVoiceMessage: Bool
    @Published var sourceUrl: String?
    
    /// Audio component
    @Published var audioRecorder: AVAudioRecorder!
    @Published var audioPlayer: AVAudioPlayer!
    
    /// View state
    @Published var state: ViewStatus = .none
    @Published var showSaveButton: Bool = false
    @Published var isRecording: Bool = false
    @Published var isPlaying: Bool = false
    @Published var voiceMessageDuration: Int = 0
    @Published var timeRemaining: Int = 60
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    /// DSWaveformImage
    @Published var waveformImageDrawer = WaveformImageDrawer()
    @Published var samples: [Float] = []
    @Published var updateTimer: Timer?
    @Published var progress: Double = 0.0
    @Published var waveformConfiguration: Waveform.Configuration = .init(
        style: .striped(.init(
            color: UIColor(Color.blue),
            width: 3,
            spacing: 3)
        ),
        damping: .init(percentage: 0.125, sides: .both)
    )
    
    /// Clean up
    var shouldCleanUp: Bool = false

    /// Alert
    @Published var appAlert: AppAlert?
    let alertTitle: String = "Oopsie!"
    let alertMessage: String = "Something went wrong. "
    let alertButtonLabel: String = "Try again"
    
    init(
        hasVoiceMessage: Bool,
        sourceUrl: String?
    ) {
        print("-> [Voice Message Edit Sheet] vm init")
        self.hasVoiceMessage = hasVoiceMessage
        self.sourceUrl = sourceUrl
    }
    
    deinit {
        print("-> [Voice Message Edit Sheet] vm deinit")
    }
}

extension VoiceMessageEditSheetViewModel {
    enum VoiceMessageError: Error {
        case unknown
        case downloadFailed
        case getPresignedUrlFailed
        case uploadS3ObjectFailed
        case deleteS3ObjectFailed
        case uploadFailed
        case updateUserFailed
    }
}

extension VoiceMessageEditSheetViewModel {
    @objc private func updateAmplitude() {
        audioRecorder.updateMeters()
        
        let currentAmplitude = 1 - pow(10, (audioRecorder.averagePower(forChannel: 0) / 20))
        samples += [currentAmplitude, currentAmplitude, currentAmplitude]
    }
    
    @objc private func updateProgress() {
        let currentTime = self.audioPlayer.currentTime
        let duration = self.audioPlayer.duration
        progress = currentTime / duration
    }
    
    @MainActor
    public func loadVoiceMessage(
        sourceUrl: String
    ) async {
        do {
            self.state = .loading
            let url = URL(string: sourceUrl)!
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else { throw FCError.VoiceMessage.downloadFailed }
            self.audioPlayer = try AVAudioPlayer(data: data)
            self.voiceMessageDuration = Int(self.audioPlayer.duration.rounded())
            self.timeRemaining = self.voiceMessageDuration
            self.state = .complete
        } catch {
            self.state = .error
            // TODO(Lawrence): show alert
            self.appAlert = .singleButton(
                        title: alertTitle,
                        message: alertMessage,
                        cancelLabel: alertButtonLabel
                        )
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    public func save() async {
        do {
            self.stopPlaying()
            self.state = .loading
            let url = try await MediaService.getPresignedPutUrl(.case(.audio))
            guard let url = url else { throw FCError.VoiceMessage.getPresignedUrlFailed }
            let result = try await AWSS3.uploadAudio(
                self.audioRecorder.url,
                toPresignedURL: URL(string: url)!
            )
            let statusCode = try await UserService.updateUser(
                userId: self.userId,
                input: GraphQLAPI.UpdateUserInput(
                    voiceContentURL: .some(result.absoluteString)
                )
            )
            guard statusCode == 200 else { throw FCError.VoiceMessage.updateUserFailed }
            self.state = .complete
        } catch {
            self.state = .error
            // TODO(Lawrence): show alert
            self.appAlert = .singleButton(
                        title: alertTitle,
                        message: alertMessage,
                        cancelLabel: alertButtonLabel
                        )
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    private func startRecording() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playAndRecord,
                mode: .default,
                options: [.allowBluetooth, .defaultToSpeaker]
            )
            let documentUrl = FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).first
            let fileName = documentUrl!.appendingPathComponent("\(UUID()).m4a")
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            self.audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            self.audioRecorder.isMeteringEnabled = true
            self.samples = []
            self.audioRecorder.record()
            self.updateTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateAmplitude), userInfo: nil, repeats: true)
            self.startTimer()
            self.isRecording = true
            self.shouldCleanUp = true
        } catch {
            self.state = .error
            // TODO(Lawrence): show alert
            self.appAlert = .singleButton(
                        title: alertTitle,
                        message: alertMessage,
                        cancelLabel: alertButtonLabel
                        )
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    public func stopRecording() async {
        do {
            self.updateTimer?.invalidate()
            self.updateTimer = nil
            self.audioRecorder.stop()
            self.stopTimer()
            self.isRecording = false
            self.hasVoiceMessage = true
            self.showSaveButton = true
            self.audioPlayer = try AVAudioPlayer(contentsOf: self.audioRecorder.url)
            self.voiceMessageDuration = Int(self.audioPlayer.duration.rounded())
            self.timeRemaining = self.voiceMessageDuration
        } catch {
            self.state = .error
            // TODO(Lawrence): show alert
            self.appAlert = .singleButton(
                        title: alertTitle,
                        message: alertMessage,
                        cancelLabel: alertButtonLabel
                        )
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    public func startPlaying() {
        self.audioPlayer.setVolume(1, fadeDuration: 0)
        self.isPlaying = true
        self.startTimer()
        self.audioPlayer.play()
        self.updateTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateProgress), userInfo: nil, repeats: true)
    }
    
    @MainActor
    public func stopPlaying() {
        self.audioPlayer.pause()
        self.timeRemaining = self.voiceMessageDuration
        self.stopTimer()
        self.isPlaying = false
        self.updateTimer?.invalidate()
        self.updateTimer = nil
    }
    
    @MainActor
    public func redo() async {
        do {
            self.stopPlaying()
            try await self.delete()
            self.hasVoiceMessage = false
            self.showSaveButton = false
            self.samples = []
        } catch {
            self.state = .error
            // TODO(Lawrence): show alert
            self.appAlert = .singleButton(
                        title: alertTitle,
                        message: alertMessage,
                        cancelLabel: alertButtonLabel
                        )
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    private func delete() async throws {
        if self.sourceUrl != "" {
            try await self.deleteRemote()
        } else {
            try await deleteLocal()
        }
        self.timeRemaining = 60
    }
    
    @MainActor
    private func deleteLocal() async throws {
        try FileManager.default.removeItem(at: self.audioRecorder.url)
    }
    
    @MainActor
    private func deleteRemote() async throws {
        guard let fileName = self.extractFileName(url: sourceUrl ?? "") else {
            throw FCError.VoiceMessage.unknown
        }
        let url = try await MediaService.getPresignedDeleteUrl(fileName: fileName)
        guard let url = url else { throw FCError.VoiceMessage.getPresignedUrlFailed }
        let success = try await AWSS3.deleteObject(presignedURL: url)
        guard success else { throw FCError.VoiceMessage.deleteS3ObjectFailed }
        let statusCode = try await UserService.updateUser(
            userId: self.userId,
            input: GraphQLAPI.UpdateUserInput(
                voiceContentURL: ""
            )
        )
        guard statusCode == 200 else { throw FCError.VoiceMessage.updateUserFailed }
    }

    @MainActor
    public func checkMicrophonePermissionAndRecord() {
        switch self.audioPermissionManager.permissionStatus {
        case .notDetermined:
            audioPermissionManager.requestPermission { granted, _ in
                guard granted else { return }
                self.startRecording()
            }
        case .denied:
            self.appAlert = .basic(
                title: self.audioPermissionManager.alertTitle,
                message: self.audioPermissionManager.alertMessage,
                actionLabel: "Settings",
                cancelLabel: "Cancel",
                action: {
                    UIApplication.shared.open(
                        URL(string: UIApplication.openSettingsURLString)!
                    )
                },
                actionButtonDefaultStyle: true
            )
        default:
            self.startRecording()
        }
    }
    
    @MainActor
    public func cleanUp() async {
        do {
            if self.shouldCleanUp {
                try await self.deleteLocal()
            }
        } catch {
            self.state = .error
            print(error.localizedDescription)
        }
    }
    
    // - MARK: helper functions
    
    private func extractFileName(
        url: String
    ) -> String? {
        if let url = URL(string: url) {
            return url.lastPathComponent
        }
        return nil
    }
    
    public func parseTime(
        seconds: Int
    ) -> String {
        let minutes = self.timeRemaining / 60
        let seconds = self.timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    public func startTimer() {
        self.timer = Timer.publish(
            every: 1,
            on: .main,
            in: .common
        ).autoconnect()
    }
    
    public func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
}