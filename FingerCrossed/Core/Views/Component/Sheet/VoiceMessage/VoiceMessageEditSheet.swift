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
    @Environment(\.dismiss) private var dismiss
    /// Init voice message edit sheet view model
    @StateObject private var vm: VoiceMessageEditSheetViewModel
    
    init(
        hasVoiceMessage: Bool,
        sourceUrl: String?
    ) {
        print("[Voice Message Edit Sheet] view init")
        _vm = StateObject(
            wrappedValue: VoiceMessageEditSheetViewModel(
                hasVoiceMessage: hasVoiceMessage,
                sourceUrl: sourceUrl
            )
        )
    }
    
    var body: some View {
        Sheet(
            size: [.height(402)],
            header: {
                ZStack(alignment: .top) {
                    Text("Voice Message")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 34)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    vm.showSaveButton
                    ? Button {
                        Task {
                            await vm.save()
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                            .foregroundColor(Color.gold)
                            .fontTemplate(.pMedium)
                            .frame(height: 34, alignment: .center)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    : nil
                }
            },
            content: {
                Text(
                    vm.hasVoiceMessage || vm.isRecording
                    ? vm.parseTime(seconds: vm.timeRemaining)
                    : "Tap to record"
                )
                .fontTemplate(.h3Bold)
                .foregroundColor(Color.surface1)
                .padding(.top, 20)
                .onAppear { vm.stopTimer()}
                .onReceive(vm.timer) { _ in
                    if vm.timeRemaining > 0 {
                        vm.timeRemaining -= 1
                    } else {
                        vm.stopTimer()
                        vm.stopPlaying()
                    }
                }
                
                VStack {
                    vm.hasVoiceMessage || vm.isRecording
                    ? LottieView(lottieFile: "soundWave")
                        .frame(height: 133)
                    : nil
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, vm.hasVoiceMessage || vm.isRecording ? 0 : 173)
                
                Button {
                    Task {
                        vm.hasVoiceMessage
                        ? vm.isPlaying
                            ? vm.stopPlaying()
                            : vm.startPlaying()
                        : vm.isRecording
                            ? await vm.stopRecording()
                            : vm.checkMicrophonePermissionAndRecord()
                    }
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
                ? Button {
                    Task { await vm.redo() }
                } label: {
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
        .task {
            if vm.hasVoiceMessage {
                await vm.loadVoiceMessage(sourceUrl: vm.sourceUrl ?? "")
            }
        }
        .onDisappear {
            Task { await vm.cleanUp() }
        }
    }
}

struct VoiceMessageEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMessageEditSheet(
            hasVoiceMessage: false,
            sourceUrl: ""
        )
    }
}
