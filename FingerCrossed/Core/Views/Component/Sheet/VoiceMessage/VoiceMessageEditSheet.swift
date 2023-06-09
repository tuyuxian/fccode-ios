//
//  VoiceMessageEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI
import AVFoundation
import GraphQLAPI

struct VoiceMessageEditSheet: View {
    /// View controller
    @Environment(\.presentationMode) private var presentationMode
    /// Observe voice message edit sheet view model
    @StateObject private var vm = VoiceMessageEditSheetViewModel()
    
    var body: some View {
        Sheet(
            size: [.height(402)],
            header: {
                ZStack(alignment: .top) {
                    Text("Voice Message")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 34)
                    
                    Button {
                        
                    } label: {
                        Text("Save")
                            .foregroundColor(Color.gold)
                            .fontTemplate(.pMedium)
                            .frame(
                                height: 34,
                                alignment: .center
                            )
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .trailing
                    )
                }
            },
            content: {
                Text(
                    vm.hasVoiceMessage || vm.isRecording
                    ? vm.parseTime(seconds: vm.timeRemaining)
                    : "01:00"
                )
                .fontTemplate(.h3Bold)
                .foregroundColor(Color.surface1)
                .padding(.top, 20)
                .onAppear {
                    vm.stopTimer()
                }
                .onReceive(vm.timer) { _ in
                    if vm.timeRemaining > 0 {
                        vm.timeRemaining -= 1
                    } else {
                        vm.stopTimer()
                        vm.stopPlaying()
                    }
                }
                
                if vm.hasVoiceMessage {
                    VStack {
                        LottieView(lottieFile: "soundWave")
                            .frame(height: 133)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    if vm.isRecording {
                        VStack {
                            LottieView(lottieFile: "soundWave")
                                .frame(height: 133)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        Text("Tap to Record")
                            .foregroundColor(Color.surface1)
                            .fontTemplate(.h3Bold)
                            .padding(.top, 20)
                        
                        Spacer()
                    }
                }
                
                Button {
                    vm.hasVoiceMessage
                    ? vm.isPlaying ? vm.stopPlaying() : vm.startPlaying()
                    : vm.isRecording ? vm.stopRecording() : vm.checkMicrophonePermissionAndRecord()
                } label: {
                    Circle()
                        .fill(Color.yellow100)
                        .frame(width: 70, height: 70)
                        .overlay(
                            Image(
                                vm.hasVoiceMessage
                                ? vm.isPlaying ? "Pause" : "Play"
                                : vm.isRecording ? "Stop" : "Mic"
                            )
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 33.6, height: 33.6)
                                .foregroundColor(Color.white)
                        )
                        .padding(.bottom, vm.hasVoiceMessage ? 24 : 51)
                }
                vm.hasVoiceMessage
                ? Button {} label: {
                    Text("Redo recording")
                        .foregroundColor(Color.text)
                        .fontTemplate(.noteMedium)
                        .underline()
                        .padding(.bottom, 9)
                }
                : nil
            },
            footer: {}
        )
        .appAlert($vm.appAlert)
    }
}

struct VoiceMessageEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMessageEditSheet()
    }
}
