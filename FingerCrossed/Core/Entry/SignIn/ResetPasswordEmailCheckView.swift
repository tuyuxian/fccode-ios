//
//  ResetPasswordEmailCheckView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/2/23.
//

import SwiftUI

struct ResetPasswordEmailCheckView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            
            VStack (spacing: 0.0){
                EntryLogo()
                
                Spacer()
                
                Text("Please check\nyour email\nto reset password")
                    .foregroundColor(.text)
                .fontTemplate(.bigBoldTitle)
                .multilineTextAlignment(.leading)
                
                
                Text("✉️")
                    .font(.custom("AzoSans-Bold", size: 160))
                    .padding(.horizontal, 33)
                
                Spacer()
                    .frame(height: 120)
                
                Button {
                    print("email check")
                } label: {
                    Text("Back to login")
                }
                .buttonStyle(PrimaryButton())
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}

struct ResetPasswordEmailCheckView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordEmailCheckView()
    }
}
