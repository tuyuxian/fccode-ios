//
//  VoiceMessageEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI
import DSWaveformImageViews

struct VoiceMessageEditSheet: View {
    /// Observed user view model
    @ObservedObject var user: UserViewModel
    /// Selected sheet from basic info
    @Binding var selectedSheet: BasicInfoViewModel.SheetView<BasicInfoDestination>?
    /// Init voice message edit sheet view model
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
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    vm.showSaveButton
                    ? Button {
                        Task {
                            await vm.save()
                            guard vm.state == .complete else { return }
                            user.data?.voiceContentURL = vm.sourceUrl
                            selectedSheet = nil
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
                        Task {
                            if vm.isPlaying {
                                vm.stopPlaying()
                            } else {
                                await vm.stopRecording()
                            }
                        }
                    }
                }
                                
                VStack {
                    if vm.hasVoiceMessage {
                        if let audioUrl = vm.audioUrl {
                            ProgressWaveformView(
                                audioURL: audioUrl,
                                progress: vm.progress
                            )
                            .frame(height: 50)
                        } else {
                            WaveformLiveCanvas(
                                samples: [],
                                configuration: vm.waveformConfiguration,
                                shouldDrawSilencePadding: true
                            )
                            .frame(height: 50)
                        }
                    } else {
                        WaveformLiveCanvas(
                            samples: vm.samples,
                            configuration: vm.waveformConfiguration,
                            shouldDrawSilencePadding: true
                        )
                        .frame(height: 100)
                    }

                }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 102)
                .padding(.vertical, 30)
                                
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
                            .padding(.bottom, vm.hasVoiceMessage ? 20 : 52)
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
                            .padding(.bottom, vm.hasVoiceMessage ? 20 : 52)
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
                        .padding(.bottom, 16)
                }
                : nil
            },
            footer: {}
        )
        .appAlert($vm.appAlert)
        .singleButtonAlert($vm.appAlert)
        .one($vm.appAlert)
//        .alert(
//            title: "Oopsie",
//            message: "Something went wrong",
//            dismissButton:
//                CustomAlertButton(
//                    title: "Try again",
//                    action: {
//                        DispatchQueue.main.async {
//                            vm.errorReset()
//                        }
//                    }
//                ),
//            isPresented: $vm.isPresented)
        .task {
            if let url = user.data?.voiceContentURL {
                if url != "" {
                    vm.hasVoiceMessage = true
                    vm.sourceUrl = url
                    await vm.loadVoiceMessage()
                }
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
            user: UserViewModel(preview: true),
            selectedSheet: .constant(
                BasicInfoViewModel.SheetView(sheetContent: .basicInfoVoiceMessage)
            )
        )
    }
}
