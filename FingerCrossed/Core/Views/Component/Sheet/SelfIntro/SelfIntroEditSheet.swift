//
//  SelfIntroEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/25/23.
//

import SwiftUI

struct SelfIntroEditSheet: View {
    @Environment(\.presentationMode) private var presentationMode
        
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
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
                            hint: "Type your self introduction",
                            defaultPresentLine: 10,
                            lineLimit: 10
                        )
                        Text("0/200")
                            .fontTemplate(.captionRegular)
                            .foregroundColor(Color.textHelper)
                        
                    }
                    .padding(.horizontal, 1) // offset border width
                    
//                    Button {
//                        presentationMode.wrappedValue.dismiss()
//                    } label: {
//                        Text("Save")
//                    }
//                    .buttonStyle(PrimaryButton())
//                    .padding(.vertical, 4) // 20 - 16
//                    .padding(.bottom, 30)
                }

            }
            .padding(.horizontal, 24)
            .background(Color.white)
            .presentationDetents([.height(436)])
            .scrollDismissesKeyboard(.immediately)
    }
}

struct SelfIntroEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        SelfIntroEditSheet()
    }
}
