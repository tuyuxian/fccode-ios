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
    
    /// Clean up
    var shouldCleanUp: Bool = false

    /// Alert
    @Published var appAlert: AppAlert?
    
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
    
    @MainActor
    public func loadVoiceMessage(
        sourceUrl: String
    ) async {
        do {
            self.state = .loading
            let url = URL(string: sourceUrl)!
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else { throw VoiceMessageError.downloadFailed }
            self.audioPlayer = try AVAudioPlayer(data: data)
            self.voiceMessageDuration = Int(self.audioPlayer.duration.rounded())
            self.timeRemaining = self.voiceMessageDuration
            self.state = .complete
        } catch {
            self.state = .error
            // TODO(Lawrence): show alert
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    public func save() async {
        do {
            self.stopPlaying()
            self.state = .loading
            let url = try await GraphAPI.getPresignedPutUrl(.case(.audio))
            guard let url = url else { throw VoiceMessageError.getPresignedUrlFailed }
            let result = try await AWSS3().uploadAudio(
                self.audioRecorder.url,
                toPresignedURL: URL(string: url)!
            )
            let statusCode = try await GraphAPI.updateUser(
                userId: self.userId,
                input: GraphQLAPI.UpdateUserInput(
                    voiceContentURL: .some(result.absoluteString)
                )
            )
            guard statusCode == 200 else { throw VoiceMessageError.updateUserFailed }
            self.state = .complete
        } catch {
            self.state = .error
            // TODO(Lawrence): show alert
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
            self.audioRecorder.record()
            self.startTimer()
            self.isRecording = true
            self.shouldCleanUp = true
        } catch {
            self.state = .error
            // TODO(Lawrence): show alert
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    public func stopRecording() async {
        do {
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
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    public func startPlaying() {
        self.audioPlayer.setVolume(1, fadeDuration: 0)
        self.isPlaying = true
        self.startTimer()
        self.audioPlayer.play()
    }
    
    @MainActor
    public func stopPlaying() {
        self.audioPlayer.pause()
        self.timeRemaining = self.voiceMessageDuration
        self.stopTimer()
        self.isPlaying = false
    }
    
    @MainActor
    public func redo() async {
        do {
            self.stopPlaying()
            try await self.delete()
            self.hasVoiceMessage = false
            self.showSaveButton = false
        } catch {
            self.state = .error
            // TODO(Lawrence): show alert
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
            throw VoiceMessageError.unknown
        }
        let url = try await GraphAPI.getPresignedDeleteUrl(fileName: fileName)
        guard let url = url else { throw VoiceMessageError.getPresignedUrlFailed }
        let success = try await AWSS3().deleteObject(presignedURL: url)
        guard success else { throw VoiceMessageError.deleteS3ObjectFailed }
        let statusCode = try await GraphAPI.updateUser(
            userId: self.userId,
            input: GraphQLAPI.UpdateUserInput(
                voiceContentURL: ""
            )
        )
        guard statusCode == 200 else { throw VoiceMessageError.updateUserFailed }
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
