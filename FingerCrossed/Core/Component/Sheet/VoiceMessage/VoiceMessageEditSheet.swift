//
//  VoiceMessageEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI

struct VoiceMessageEditSheet: View {
    // TODO(Lawrence): add sound wave animation
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 6) {
                Text("Voice Message")
                    .fontTemplate(.h2Medium)
                    .foregroundColor(Color.text)
                Text("00:00")
                    .fontTemplate(.pMedium)
                    .foregroundColor(Color.text)
                    .padding(.bottom, 30)
                Button {
                    
                } label: {
                    Image("Mic")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.orange100)
                }
                .frame(width: 60, height: 60)
                .overlay(
                    Circle()
                        .stroke(Color.surface3, lineWidth: 18)
                           .frame(width: 96, height: 96)
                )
                
            }
            .background(Color.white)
            .presentationDetents([.fraction(0.25)])
        }
    }
}

struct VoiceMessageEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMessageEditSheet()
    }
}
