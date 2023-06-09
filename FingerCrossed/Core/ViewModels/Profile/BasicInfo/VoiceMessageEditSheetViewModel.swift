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
    
    let audioPermissionManager = AudioPermissionManager()
        
    @AppStorage("UserId") private var userId: String = ""
    
    @Published var audioRecorder: AVAudioRecorder!
    @Published var audioPlayer: AVAudioPlayer!

    @Published var isLoading: Bool = false
    @Published var isSatisfied: Bool = false
    
    @Published var isRecording: Bool = false
    @Published var isPlaying: Bool = false
    @Published var hasVoiceMessage: Bool = false
    
    @Published var appAlert: AppAlert?

    @Published var voiceMessageDuration: Int = 0
    @Published var timeRemaining: Int = 60
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}

extension VoiceMessageEditSheetViewModel {
    
    public func saveButtonOnTap() {
        Task {
            do {
                let url = try await GraphAPI.getPresignedPutUrl(.case(.audio))
                guard let url = url else {
                    return
                }
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
                guard statusCode == 200 else {
                    return
                }
            }
        }
    }
    
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
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.record()
            startTimer()
            isRecording.toggle()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func stopRecording() {
        audioRecorder.stop()
        stopTimer()
        isRecording.toggle()
        hasVoiceMessage = true
        DispatchQueue.main.async {
            Task {
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: self.audioRecorder.url)
                    self.voiceMessageDuration = Int(self.audioPlayer.duration.rounded())
                    self.timeRemaining = self.voiceMessageDuration
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    public func startPlaying() {
        DispatchQueue.main.async {
            Task {
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: self.audioRecorder.url)
                    self.audioPlayer.setVolume(1, fadeDuration: 0)
                    self.isPlaying.toggle()
                    self.startTimer()
                    self.audioPlayer.play()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    public func stopPlaying() {
        audioPlayer.pause()
        timeRemaining = voiceMessageDuration
        stopTimer()
        isPlaying.toggle()
    }
    
    private func removeRecording() {
        do {
            try FileManager.default.removeItem(at: audioRecorder.url)
            self.timeRemaining = 60
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func parseTime(
        seconds: Int
    ) -> String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
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
}
