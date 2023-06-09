//
//  TermsOfServiceSheet.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/23/23.
//

import SwiftUI

struct TermsOfServiceSheet: View {
    
    @Environment(\.presentationMode) private var presentationMode
        
    var body: some View {
        Sheet(
            size: [.large],
            hasFooter: false,
            header: {
                ZStack(alignment: .top) {
                    Text("Terms of Service")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 34)
                    
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .fontTemplate(.pMedium)
                    .foregroundColor(Color.gold)
                    .frame(height: 34, alignment: .center)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .trailing
                    )
                }
                .padding(.top, 15) // 30 - 15
            },
            content: {
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(
                            alignment: .leading,
                            spacing: 0
                        ) {
                            TermsOfService()
                        }
                    }
                    .padding(.top, 30)
                    .scrollIndicators(.hidden)
                }
            },
            footer: {}
        )
    }
}

struct TermsOfServiceSheet_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceSheet()
    }
}
