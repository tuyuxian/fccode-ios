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
        ZStack(
            alignment: Alignment(
                horizontal: .leading,
                vertical: .top
            )
        ) {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                            .foregroundColor(Color.gold)
                            .fontTemplate(.pMedium)
                    }
                }
                .padding(.top, 35)
                .padding(.bottom, 16)
                .frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
                
                ScrollView {
                    VStack(
                        alignment: .leading,
                        spacing: 0
                    ) {
                        TermsOfService()
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, 24)
            .background(Color.white)
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}

struct TermsOfServiceSheet_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceSheet()
    }
}
