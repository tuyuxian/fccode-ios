//
//  VoiceRecordButton.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/12/23.
//

import SwiftUI

struct VoiceRecordButton: View {
    
    @State var showVocieRecordSheet: Bool = false
    
    var body: some View {
        Button {
            showVocieRecordSheet.toggle()
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
        .sheet(isPresented: $showVocieRecordSheet) {
            VoiceMessageEditSheet()
        }
    }
}

struct VoiceRecordButton_Previews: PreviewProvider {
    static var previews: some View {
        VoiceRecordButton()
    }
}
