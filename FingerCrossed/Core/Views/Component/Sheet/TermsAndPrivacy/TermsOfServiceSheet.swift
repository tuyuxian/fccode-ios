//
//  TermsOfServiceSheet.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/23/23.
//

import SwiftUI

struct TermsOfServiceSheet: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            VStack {
                Button {
                    isPresented = false
                } label: {
                    Text("Done")
                        .foregroundColor(Color.gold)
                        .fontTemplate(.pMedium)
                }
            }
            .padding(.top, 35)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            ScrollView {
                VStack(
                    alignment: .leading,
                    spacing: 0
                ) {
                    TermsOfService()
                }
                .padding(.vertical, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 24)
    }
}

private var bool: Binding<Bool> {
    Binding.constant(false)
}

struct TermsOfServiceSheet_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceSheet(isPresented: bool)
    }
}
