//
//  PrivacySheet.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/23/23.
//

import SwiftUI

struct PrivacySheet: View {

    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        Sheet(
            size: [.large],
            hasHeader: false,
            hasFooter: false,
            content: {
                VStack(spacing: 0) {
                    ZStack(alignment: .top) {
                        Text("Privacy")
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
                    .padding(.bottom, 30)
                    
                    ScrollView {
                        VStack(
                            alignment: .leading,
                            spacing: 0
                        ) {
                            Privacy()
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            },
            footer: {}
        )
    }
}

struct PrivacySheet_Previews: PreviewProvider {
    static var previews: some View {
        PrivacySheet()
    }
}
