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
    
    public func startRecording() {
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
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.record()
            isRecording.toggle()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func stopRecording() {
        audioRecorder.stop()
        isRecording.toggle()
        hasVoiceMessage = true
    }
    
    public func startPlaying() {
        let playerItem = AVPlayerItem(url: audioRecorder.url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        
        audioPlayer.play()
        isPlaying.toggle()
    }
    
    public func stopPlaying() {
        audioPlayer.pause()
        isPlaying.toggle()
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
                
                Text("Voice Message")
                     .fontTemplate(.h2Medium)
                     .foregroundColor(Color.text)
                     .padding(.top, 30)
                
                 Text("01:00")
                     .fontTemplate(.h3Bold)
                     .foregroundColor(Color.surface1)
                
                Spacer()
                
                if hasVoiceMessage {
                    HStack(
                         alignment: .center,
                         spacing: 16
                     ) {
                         Button {
                             isPlaying
                             ? stopPlaying()
                             : startPlaying()
                         } label: {
                             Image(isPlaying ? "pause" : "play")
                                 .renderingMode(.template)
                                 .resizable()
                                 .foregroundColor(Color.white)
                                 .frame(width: 18, height: 18)
                                 .background(
                                     Circle()
                                         .fill(Color.yellow100)
                                         .frame(width: 50, height: 50)
                                 )
                         }
                        
                         VStack {
                             LottieView(lottieFile: "soundWave")
                                 .frame(height: 100)
                         }
                         .frame(maxWidth: .infinity, alignment: .center)
                     }
                     .padding(.leading, 16)
                } else {
                    LottieView(lottieFile: "soundWave")
                        .frame(height: 100)
                        .padding(.bottom, 20)
                }
                
                Spacer()
                
                if hasVoiceMessage {
                    PrimaryButton(
                        label: "Save",
                        action: buttonOnTap,
                        isTappable: $isSatisfied,
                        isLoading: $isLoading
                    )
                } else {
                    Button {
                        isRecording
                        ? stopRecording()
                        : startRecording()
                     } label: {
                         Image("Mic")
                             .renderingMode(.template)
                             .resizable()
                             .frame(width: 38.4, height: 38.4)
                             .foregroundColor(Color.white)
                             .background(
                                 Circle()
                                     .fill(Color.yellow100)
                                     .frame(width: 80, height: 80)
                             )
                     }
                     .padding(.top, 20.8)
                     .padding(.bottom, 62)
                }
            }
            .padding(.horizontal, 24)
            .background(Color.white)
            .presentationDetents([.fraction(0.55)])
            .presentationDragIndicator(.visible)
        }
    }
}

struct VoiceMessageEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMessageEditSheet()
    }
}
