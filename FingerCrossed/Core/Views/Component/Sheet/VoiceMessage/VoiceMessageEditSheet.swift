//
//  VoiceMessageEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI
import AVFoundation
import GraphQLAPI
import DSWaveformImageViews

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
                            guard vm.state == .complete else { return }
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
                    vm.state == .loading
                    ? "--:--"
                    : vm.hasVoiceMessage || vm.isRecording
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
                Spacer()
                
                VStack {
                    if vm.hasVoiceMessage {
                        if let audioUrl = vm.audioUrl {
                            ProgressWaveformView(
                                audioURL: audioUrl,
                                progress: vm.progress
                            )
                            .frame(height: 50)
                        } else {
                            Text("123")
                        }
                    } else {
                        WaveformLiveCanvas(
                            samples: vm.samples,
                            configuration: vm.waveformConfiguration,
                            shouldDrawSilencePadding: true
                        )
                        .frame(height: 50)
                    }

                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
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
                    if vm.state == .loading {
                        Circle()
                            .fill(Color.yellow100)
                            .frame(width: 70, height: 70)
                            .overlay(
                                LottieView(lottieFile: "spinner.json")
                                    .frame(width: 33.6, height: 33.6)
                            )
                            .padding(.bottom, 51)
                    } else {
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
        .singleButtonAlert($vm.appAlert)
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
