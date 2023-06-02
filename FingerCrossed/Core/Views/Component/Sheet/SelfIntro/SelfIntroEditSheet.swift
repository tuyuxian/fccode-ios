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
        Sheet(
            size: [.medium],
            header: "Self Introduction",
            content: {
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
                .padding(.top, 30)
                
                Spacer()
            },
            footer: {
                PrimaryButton(
                    label: "Save",
                    action: buttonOnTap,
                    isTappable: $isSatisfied,
                    isLoading: $isLoading
                )
                .padding(.bottom, 16)
            }
        )
    }
}

struct SelfIntroEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        SelfIntroEditSheet()
    }
}
