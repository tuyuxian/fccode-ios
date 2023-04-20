//
//  VoiceRecordButton.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/12/23.
//

import SwiftUI

struct VoiceRecordButton: View {
    var body: some View {
        Button {
            // TODO(Sam): add action for voice record
        } label: {
            HStack(alignment: .center, spacing: 0) {
                Text("Press to record message")
                Spacer()
                Image("Mic")
            }
            .padding(EdgeInsets(top: 15, leading: 16, bottom: 15, trailing: 16))
        }
        .frame(height:54)
        .fontTemplate(.pMedium)
        .foregroundColor(Color.orange100)
        .background(Color.yellow20)
        .cornerRadius(50)
    }
}

struct VoiceRecordButton_Previews: PreviewProvider {
    static var previews: some View {
        VoiceRecordButton()
    }
}
