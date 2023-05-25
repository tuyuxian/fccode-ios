//
//  VoiceMessageEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI
import AVFoundation

struct VoiceMessageEditSheet: View {
    // @State private var isStatisfied: Bool = true
    
    // @State private var isLoading: Bool = false
    
    // @State var hasVoiceMessage: Bool = true
    // // TODO(Lawrence): apply new design
    // var body: some View {
    //     ZStack {
    //         Color.white.edgesIgnoringSafeArea(.all)
    //         VStack(alignment: .center, spacing: 20) {
    //             Text("Voice Message")
    //                 .fontTemplate(.h2Medium)
    //                 .foregroundColor(Color.text)
    //                 .padding(.top, 30)
    //             Text("01:00")
    //                 .fontTemplate(.h3Bold)
    //                 .foregroundColor(Color.surface1)
    //                 .padding(.bottom, 50)
                
    //             if hasVoiceMessage {
    //                 HStack(
    //                     alignment: .center,
    //                     spacing: 16
    //                 ) {
    //                     Button {
                            
    //                     } label: {
    //                         Image("play")
    //                             .renderingMode(.template)
    //                             .resizable()
    //                             .foregroundColor(Color.white)
    //                             .frame(width: 18, height: 18)
    //                             .background(
    //                                 Circle()
    //                                     .fill(Color.yellow100)
    //                                     .frame(width: 50, height: 50)
    //                             )
    //                     }
                        
    //                     VStack {
    //                         LottieView(lottieFile: "soundwave.json")
    //                             .frame(width: 233.05, height: 50)
    //                     }
    //                     .frame(maxWidth: .infinity, alignment: .center)
    //                 }
    //                 .padding(EdgeInsets(top: 0, leading: 40, bottom: 80, trailing: 24))
    //             } else {
    //                 LottieView(lottieFile: "soundwave.json")
    //                     .frame(width: 233.05, height: 50)
    //                     .padding(.bottom, 50)
    //             }
                
    //             if hasVoiceMessage {
    //                 PrimaryButton(
    //                     label: "Save",
    //                     isTappable: $isStatisfied,
    //                     isLoading: $isLoading
    //                 )
    //                 .padding(.horizontal, 24)
    //                 .padding(.bottom, 40)
    //             } else {
    //                 Button {
                        
    //                 } label: {
    //                     Image("Mic")
    //                         .renderingMode(.template)
    //                         .resizable()
    //                         .frame(width: 38.4, height: 38.4)
    //                         .foregroundColor(Color.white)
    //                         .background(
    //                             Circle()
    //                                 .fill(Color.yellow100)
    //                                 .frame(width: 80, height: 80)
    //                         )
    //                 }
    //                 .padding(.bottom, 62)
    //             }
                
    
    @Environment(\.presentationMode) private var presentationMode
        
    @State private var isSatisfied: Bool = false
    
    @State private var isLoading: Bool = false
    
    @State var audioRecorder: AVAudioRecorder!
    
    @State var audioPlayer: AVPlayer!
        
    @State var isRecording: Bool = false
    
    @State var isPlaying: Bool = false

    private func buttonOnTap() {
        Task {
            do {
                let result = await AWSS3().uploadAudio(
                    audioRecorder.url,
                    // TODO(Sam): replace with presigned Url generated from backend
                    toPresignedURL: URL(string: "")!
                )
                print(result)
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
            )[0]
            let fileName = documentUrl.appendingPathComponent("\(UUID()).m4a")
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
    }
    
    public func startPlaying() {
        let playerItem = AVPlayerItem(url: audioRecorder.url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer.play()
    }
    
    public func stopPlaying() {
        audioPlayer.pause()
    }
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .leading,
                vertical: .top
            )
        ) {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                VStack(spacing: 0) {
                    Text("Voice Message")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 34)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                    Text("Click to replay")
                        .fontTemplate(.noteMedium)
                        .foregroundColor(Color.text)
                        .frame(height: 16)
                        .multilineTextAlignment(.center)
                }
                
                Button {
                    isRecording
                    ? stopRecording()
                    : startRecording()
                } label: {
                    Text("Record audio")
                }
                
                Button {
                    isPlaying
                    ? stopPlaying()
                    : startPlaying()
                } label: {
                    Text("Play audio")
                }
                
                PrimaryButton(
                    label: "Save",
                    action: buttonOnTap,
                    isTappable: $isSatisfied,
                    isLoading: $isLoading
                )
                .padding(.top, 4) // 20 - 16(spacing)
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
