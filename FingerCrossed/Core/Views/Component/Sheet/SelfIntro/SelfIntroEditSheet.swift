//
//  SelfIntroEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/25/23.
//

import SwiftUI

struct SelfIntroEditSheet: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State var text: String = ""
    
    @State private var isSatisfied: Bool = false
    
    @State private var isLoading: Bool = false
            
    let textLengthLimit: Int = 200
    
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
                Text("Self Introduction")
                    .fontTemplate(.h2Medium)
                    .foregroundColor(Color.text)
                    .frame(height: 34)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                    .id(2)
                
                VStack(
                    alignment: .trailing,
                    spacing: 6
                ) {
                    CaptionInputBar(
                        text: $text,
                        hint: "Type your self introduction",
                        defaultPresentLine: 10,
                        lineLimit: 10,
                        textLengthLimit: textLengthLimit
                    )
                    .onChange(of: text) { _ in
                        isSatisfied = true
                    }
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
            .scrollDismissesKeyboard(.automatic)
        }
    }
}

struct SelfIntroEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        SelfIntroEditSheet()
    }
}
