//
//  VoiceMessageEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI

struct VoiceMessageEditSheet: View {
    
    @Environment(\.presentationMode) private var presentationMode
        
    @State private var isSatisfied: Bool = false
    
    @State private var isLoading: Bool = false
                
    private func buttonOnTap() {
        // TODO(Sam): update to server before view dismiss
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .leading,
                vertical: .top
            )
        ) {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                VStack(spacing: 0) {
                    Text("Voice Message")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 34)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                    Text("Click to replay")
                        .fontTemplate(.noteMedium)
                        .foregroundColor(Color.text)
                        .frame(height: 16)
                        .multilineTextAlignment(.center)
                }
                
                PrimaryButton(
                    label: "Save",
                    action: buttonOnTap,
                    isTappable: $isSatisfied,
                    isLoading: $isLoading
                )
                .padding(.top, 4) // 20 - 16(spacing)
            }
            .padding(.horizontal, 24)
            .background(Color.white)
            .presentationDetents([.fraction(0.55)])
            .presentationDragIndicator(.visible)
        }
    }
}

struct VoiceMessageEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMessageEditSheet()
    }
}
