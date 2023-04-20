//
//  VoiceRecordSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/16/23.
//

import SwiftUI
//import DSWaveformImage
//import DSWaveformImageViews

struct VoiceRecordSheet: View {
    @State var audioURL = Bundle.main.url(forResource: "example_sound", withExtension: "m4a")!
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        //WaveformView(audioURL: audioURL)
    }
}

struct VoiceRecordSheet_Previews: PreviewProvider {
    static var previews: some View {
        VoiceRecordSheet()
    }
}
