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
                    
                    HStack {
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
                        }
                        : nil
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 24)
            },
            content: {
                VStack(spacing: 0) {
                    Text(
                        vm.state == .loading && !vm.hasVoiceMessage
                        ? "--:--"
                        : vm.hasVoiceMessage || vm.isRecording
                        ? vm.parseTime(seconds: vm.timeRemaining)
                        : "Tap to record"
                    )
                    .fontTemplate(.h3Bold)
                    .foregroundColor(Color.surface1)
                    .padding(.top, 20)
                    .onAppear { vm.stopTimer()}
                    .onAppear {
                        Timer.scheduledTimer(
                            withTimeInterval: 0.1,
                            repeats: true
                        ) { _ in
                            if let player = vm.audioPlayer {
                                if !player.isPlaying {
                                    if vm.isPlaying {
                                        vm.stopPlaying()
                                    }
                                }
                            }
                        }
                    }
                    .onReceive(vm.timer) { _ in
                        if vm.timeRemaining > 0 {
                            vm.timeRemaining -= 1
                        } else {
                            vm.stopTimer()
                            Task {
                                if vm.isRecording {
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
                    
                    VStack(spacing: vm.hasVoiceMessage ? 20 : 52) {
                        if vm.state == .loading {
                            Circle()
                                .fill(Color.yellow100)
                                .frame(width: 70, height: 70)
                                .overlay(
                                    LottieView(lottieFile: "spinner.json")
                                        .frame(width: 32, height: 32)
                                )
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
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(Color.white)
                                )
                                .onTapGesture {
                                    Task {
                                        vm.hasVoiceMessage
                                        ? vm.isPlaying
                                            ? vm.stopPlaying()
                                            : vm.startPlaying()
                                        : vm.isRecording
                                            ? await vm.stopRecording()
                                            : vm.checkMicrophonePermissionAndRecord()
                                    }
                                }
                                .alert(isPresented: $vm.showMicrophoneAlert) {
                                    Alert(
                                        title:
                                            Text(vm.audioPermissionManager.alertTitle)
                                            .font(Font.system(size: 18, weight: .medium)),
                                        message:
                                            Text(vm.audioPermissionManager.alertMessage)
                                            .font(Font.system(size: 12, weight: .medium)),
                                        primaryButton: .default(Text("Cancel")),
                                        secondaryButton: .default(
                                            Text("Settings"),
                                            action: {
                                                UIApplication.shared.open(
                                                    URL(string: UIApplication.openSettingsURLString)!
                                                )
                                            }
                                        )
                                    )
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
                        }
                        : nil
                    }
                }
                .padding(.bottom, 16)
                .padding(.horizontal, 24)
            },
            footer: {}
        )
        .showAlert($vm.fcAlert)
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
            Task {
                if vm.audioPlayer != nil {
                    vm.stopPlaying()
                }
                if vm.audioRecorder != nil {
                    await vm.stopRecording()
                }
                await vm.cleanUp()
            }
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
