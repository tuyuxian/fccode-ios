//
//  ProgressWaveformView.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/12/23.
//

import SwiftUI
import DSWaveformImage

struct ProgressWaveformView: View {
    let audioURL: URL
    let progress: Double

    private let configuration = Waveform.Configuration(
        style: .striped(.init(color: UIColor(Color.blue), width: 3, spacing: 3)),
        damping: .init(percentage: 0.125, sides: .both)
    )

    @StateObject private var waveformDrawer = WaveformImageDrawer()
    @State private var waveformImage: UIImage = UIImage()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(uiImage: waveformImage)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.textHelper)

                Image(uiImage: waveformImage)
                    .resizable()
                    .mask(alignment: .leading) {
                        Rectangle().frame(width: geometry.size.width * progress)
                    }
            }
                .onAppear {
                    guard waveformImage.size == .zero else { return }
                    update(size: geometry.size, url: audioURL, configuration: configuration)
                }
                .onChange(of: geometry.size) { update(size: $0, url: audioURL, configuration: configuration) }
                .onChange(of: audioURL) { update(size: geometry.size, url: $0, configuration: configuration) }
                .onChange(of: configuration) { update(size: geometry.size, url: audioURL, configuration: $0) }
        }
    }
    
    private func update(size: CGSize, url: URL, configuration: Waveform.Configuration) {
        Task(priority: .userInitiated) {
            let image = try! await waveformDrawer.waveformImage(fromAudioAt: url, with: configuration.with(size: size))
            await MainActor.run { waveformImage = image }
        }
    }
}

struct ProgressWaveformView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressWaveformView(audioURL: URL(fileURLWithPath: ""), progress: 0.0)
    }
}
