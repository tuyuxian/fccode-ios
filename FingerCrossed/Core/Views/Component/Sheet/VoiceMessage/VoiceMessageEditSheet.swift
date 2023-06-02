//
//  VoiceMessageEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI
import AVFoundation

struct VoiceMessageEditSheet: View {
    @Environment(\.presentationMode) private var presentationMode
        
    @State private var isSatisfied: Bool = false
    
    @State private var isLoading: Bool = false
    
    @State var audioRecorder: AVAudioRecorder!
    
    @State var audioPlayer: AVPlayer!
        
    @State var isRecording: Bool = false
    
    @State var isPlaying: Bool = false
    
    @State var hasVoiceMessage: Bool = false
    
    @State var voiceMessageDuration: Int = 0
    
    @State var timeRemaining: Int = 59
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let numberFormatter = NumberFormatter()

    private func buttonOnTap() {
        Task {
            do {
//                let result = await AWSS3().uploadAudio(
//                    audioRecorder.url,
//                    // TODO(Sam): replace with presigned Url generated from backend
//                    toPresignedURL: URL(string: "")!
//                )
//                print(result)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private func startRecording() {
        let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord)
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            let documentUrl = FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).first
            let fileName = documentUrl!.appendingPathComponent("\(UUID()).m4a")
            let settings = [
                AVFormatIDKey: Int(kAudioFormatAppleLossless),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
            ]
//            let settings = [
//                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//                AVSampleRateKey: 12000,
//                AVNumberOfChannelsKey: 1,
//                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//            ]
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.record()
            startTimer()
            isRecording.toggle()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func stopRecording() async {
        audioRecorder.stop()
        stopTimer()
        isRecording.toggle()
        hasVoiceMessage = true
        
        let playerItem = AVPlayerItem(url: audioRecorder.url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        
        do {
            let duration = try await playerItem.asset.load(.duration)
            numberFormatter.maximumFractionDigits = 0
            numberFormatter.minimumIntegerDigits = 2
            
            voiceMessageDuration = Int(numberFormatter.string(from: ceil(CMTimeGetSeconds(duration)) as NSNumber)!)!
            
            timeRemaining = voiceMessageDuration
        } catch {
            print("durationError: \(error)")
        }
    }
    
    private func startPlaying() {
        let playerItem = AVPlayerItem(url: audioRecorder.url)
        audioPlayer = AVPlayer(playerItem: playerItem)

        audioPlayer.volume = 500
        audioPlayer.play()
        startTimer()
        isPlaying.toggle()
    }
    
    private func stopPlaying() {
        audioPlayer.pause()
        timeRemaining = voiceMessageDuration
        stopTimer()
        isPlaying.toggle()
    }
    
    private func removeRecording() {
        do {
            try FileManager.default.removeItem(at: audioRecorder.url)
            timeRemaining = 59
        } catch {
            print("Can't delete")
        }
    }
    
    private func startTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        print("startTimer")
    }
    
    private func stopTimer() {
        self.timer.upstream.connect().cancel()
        print("stopTimer")
    }
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .center,
                vertical: .top
            )
        ) {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                ZStack {
                    Text("Voice Message")
                         .fontTemplate(.h2Medium)
                         .foregroundColor(Color.text)
                    
                    Button {
                        buttonOnTap()
                    } label: {
                        Text("Save")
                            .foregroundColor(Color.gold)
                            .fontTemplate(.pMedium)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.top, 30)
                
                Text(hasVoiceMessage || isRecording ? "00:\(numberFormatter.string(from: timeRemaining as NSNumber)!)" : "01:00")
                     .fontTemplate(.h3Bold)
                     .foregroundColor(Color.surface1)
                     .onAppear {
                         numberFormatter.minimumIntegerDigits = 2
                         numberFormatter.maximumFractionDigits = 0
                         stopTimer()
                     }
                
//                Spacer()
                
                if hasVoiceMessage {
                     VStack {
                         LottieView(lottieFile: "soundWave")
                             .frame(height: 133)
                     }
                     .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    if isRecording {
                        VStack {
                            LottieView(lottieFile: "soundWave")
                                .frame(height: 133)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        Text("Press to Record")
                            .foregroundColor(Color.text)
                            .fontTemplate(.h2Medium)
                            .padding(.top, 56)
                            .padding(.bottom, 43)
                    }
                }
                
//                Spacer()
                
                Button {
                    hasVoiceMessage
                    ?
                    isPlaying
                    ?
                    Task {
                        stopPlaying()
                    }
                    :
                    Task {
                        startPlaying()
                    }
                    :
                    Task {
                        await isRecording
                        ? stopRecording()
                        : startRecording()
                    }
                    
                 } label: {
                     Image(hasVoiceMessage ? isPlaying ? "Pause" : "Play" : isRecording ? "Stop" : "Mic")
                         .renderingMode(.template)
                         .resizable()
                         .frame(width: 33.6, height: 33.6)
                         .foregroundColor(Color.white)
                         .background(
                             Circle()
                                 .fill(Color.yellow100)
                                 .frame(width: 70, height: 70)
                         )
                 }
                 .padding(.top, 18.2)
                 .padding(.bottom, hasVoiceMessage ? 22.2 : 83.2)

                hasVoiceMessage ?
                Button {
                    // remove record file
                    removeRecording()
                    hasVoiceMessage.toggle()
                } label: {
                    Text("Re-record")
                        .foregroundColor(Color.text)
                        .fontTemplate(.noteMedium)
                        .underline()
                }
                .padding(.bottom, 25)
                : nil

            }
            .padding(.horizontal, 24)
            .background(Color.white)
            .presentationDetents([.fraction(0.55)])
            .presentationDragIndicator(.visible)
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
                stopPlaying()
            }
        }
    }
}

struct VoiceMessageEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMessageEditSheet()
    }
}
