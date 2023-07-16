//
//  CandidateDetailView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/17/23.
//

import SwiftUI
import AVFoundation
import DSWaveformImage
import DSWaveformImageViews

struct CandidateDetailView: View {

    @StateObject private var vm = ViewModel()
    
    @ObservedObject var candidate: CandidateModel
    
    @State var showIndicator: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 20) {
                showIndicator
                ? Capsule()
                    .fill(Color.surface1)
                    .opacity(0.5)
                    .frame(width: 35, height: 5)
                    .padding(.top, 10)
                    .padding(.bottom, -5)
                : nil
                
                Text(candidate.username)
                    .fontTemplate(.h2Medium)
                    .foregroundColor(Color.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider().overlay(Color.surface1)
            }
            
            ScrollViewReader { scrollProxy in
                ScrollView(showsIndicators: false) {
                    VStack(
                        alignment: .leading,
                        spacing: 20
                    ) {
                        InfoCard(
                            candidate: candidate,
                            labelColor: Color.text
                        )
                        .padding(.top, 20)
                        .id("scroll_to_top")
                        
                        Text(candidate.selfIntro)
                            .fontTemplate(.pRegular)
                            .foregroundColor(Color.text)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if let url = candidate.voiceContentUrl {
                            if url != "" && vm.state != .error {
                                VStack(spacing: 20) {
                                    Text("Voice Message")
                                        .fontTemplate(.pMedium)
                                        .foregroundColor(Color.text)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack(spacing: 16) {
                                        if vm.state == .loading {
                                            Circle()
                                                .foregroundColor(Color.yellow100)
                                                .frame(width: 42, height: 42)
                                                .overlay(
                                                    LottieView(lottieFile: "spinner.json")
                                                        .frame(width: 24, height: 24)
                                                )
                                        } else {
                                            Circle()
                                                .foregroundColor(Color.yellow100)
                                                .frame(width: 42, height: 42)
                                                .overlay(
                                                    vm.isPlaying
                                                    ? FCIcon.pause
                                                        .resizable()
                                                        .renderingMode(.template)
                                                        .foregroundColor(Color.white)
                                                        .frame(width: 24, height: 24)
                                                    : FCIcon.play
                                                        .resizable()
                                                        .renderingMode(.template)
                                                        .foregroundColor(Color.white)
                                                        .frame(width: 24, height: 24)
                                                )
                                                .onTapGesture {
                                                    vm.isPlaying
                                                    ? vm.stopPlaying()
                                                    : vm.startPlaying()
                                                }
                                        }
                                        if let audioUrl = vm.audioUrl {
                                            ProgressWaveformView(
                                                audioURL: audioUrl,
                                                progress: vm.progress
                                            )
                                            .frame(height: 42)
                                        }
                                    }
                                }
                                .task {
                                    vm.hasVoiceMessage = true
                                    Task { await vm.loadVoiceMessage(sourceUrl: url) }
                                }
                                .onAppear {
                                    Timer.scheduledTimer(
                                        withTimeInterval: 0.1,
                                        repeats: true
                                    ) { _ in
                                        if let player = vm.audioPlayer {
                                            if !player.isPlaying {
                                                vm.isPlaying = false
                                            }
                                        }
                                    }
                                }
                                .onDisappear {
                                    if vm.audioPlayer != nil {
                                        vm.stopPlaying()
                                    }
                                    vm.cleanUp()
                                }
                            }
                        }
                        
                        ForEach(candidate.lifePhotos, id: \.self.id) { lifePhoto in
                            VStack(spacing: 11) {
                                FCAsyncImage(
                                    url: URL(string: lifePhoto.contentUrl)!
                                )
                                .cornerRadius(16)
                                
                                Text(lifePhoto.caption)
                                    .foregroundColor(Color.text)
                                    .fontTemplate(.pRegular)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        PrimaryButton(
                            label: "Back to top",
                            action: {
                                withAnimation(.interactiveSpring()) {
                                    scrollProxy.scrollTo("scroll_to_top", anchor: .top)
                                }
                            },
                            isTappable: .constant(true),
                            isLoading: .constant(false)
                        )
                    }
                    .padding(.bottom, 16)
                }
            }
        }
        .padding(.horizontal, 24)
    }
}

struct CandidateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CandidateDetailView(
            candidate: CandidateModel.MockCandidate
        )
    }
}

extension CandidateDetailView {
    
    struct LabelItem: View {
        
        let icon: FCIcon
        
        let label: String
        
        let iconColor: Color
        
        let labelColor: Color
        
        var body: some View {
            HStack(spacing: 4) {
                icon.resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundColor(iconColor)
                Text(label)
                    .fontTemplate(.pMedium)
                    .foregroundColor(labelColor)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}

extension CandidateDetailView {

    struct InfoCard: View {

        let candidate: CandidateModel
        
        var labelColor: Color

        var body: some View {
            VStack(
                spacing: 10
            ) {
                HStack(spacing: 0) {
                    CandidateDetailView.LabelItem(
                        icon: .genderWhite,
                        label: candidate.gender.getString(),
                        iconColor: labelColor,
                        labelColor: labelColor
                    )

                    CandidateDetailView.LabelItem(
                        icon: .ageWhite,
                        label: candidate.getAge(),
                        iconColor: labelColor,
                        labelColor: labelColor
                    )
                }

                HStack(spacing: 0) {
                    if candidate.location != "" {
                        CandidateDetailView.LabelItem(
                            icon: .locationWhite,
                            label: candidate.location,
                            iconColor: labelColor,
                            labelColor: labelColor
                        )
                    }

                    CandidateDetailView.LabelItem(
                        icon: .globeWhite,
                        label: Nationality.getNationalitiesCode(
                            from: candidate.nationality
                        ),
                        iconColor: labelColor,
                        labelColor: labelColor
                    )
                }
            }
        }
    }

}

extension CandidateDetailView {
    
    class ViewModel: ObservableObject {
        
        /// Network
        var session: URLSession = .audioSession
        
        /// Audio component
        @Published var audioPlayer: AVAudioPlayer!
        @Published var audioUrl: URL?
        
        /// View state
        @Published var state: ViewStatus = .none
        @Published var hasVoiceMessage: Bool = false
        @Published var isPlaying: Bool = false
        
        /// DSWaveformImage
        @Published var waveformImageDrawer = WaveformImageDrawer()
        @Published var samples: [Float] = []
        @Published var updateTimer: Timer?
        @Published var progress: Double = 0.0
        @Published var waveformConfiguration: Waveform.Configuration = .init(
            style: .striped(.init(
                color: UIColor(Color.yellow20),
                width: 3,
                spacing: 3)
            ),
            damping: .init(percentage: 0.125, sides: .both)
        )
        
        @MainActor
        public func loadVoiceMessage(
            sourceUrl: String
        ) async {
            do {
                self.state = .loading
                let url = URL(string: sourceUrl)!
                let (data, response) = try await session.data(for: URLRequest(url: url))
                guard let response = response as? HTTPURLResponse,
                      200...299 ~= response.statusCode else { throw FCError.VoiceMessage.downloadFailed }
                let cachesFolderURL = try? FileManager.default.url(
                    for: .cachesDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil,
                    create: false
                )
                let audioFileURL = cachesFolderURL!.appendingPathComponent("\(UUID()).m4a")
                try data.write(to: audioFileURL)
                self.audioUrl = audioFileURL
                self.audioPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
                self.state = .complete
            } catch {
                self.state = .error
                print(error.localizedDescription)
            }
        }
        
        @MainActor
        public func startPlaying() {
            self.audioPlayer.setVolume(1, fadeDuration: 0)
            self.isPlaying = true
            self.audioPlayer.play()
            self.updateTimer = Timer.scheduledTimer(
                timeInterval: 0.01,
                target: self,
                selector: #selector(self.updateProgress),
                userInfo: nil,
                repeats: true
            )
        }

        @MainActor
        public func stopPlaying() {
            self.audioPlayer.pause()
            self.isPlaying = false
            self.progress = 0.0
            self.updateTimer?.invalidate()
            self.updateTimer = nil
        }
        
        @MainActor
        public func cleanUp() {
            if let localUrl = self.audioUrl {
                do {
                    try FileManager.default.removeItem(at: localUrl)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        @objc private func updateProgress() {
            let currentTime = self.audioPlayer.currentTime
            let duration = self.audioPlayer.duration
            progress = currentTime / duration
        }
    }
    
}
