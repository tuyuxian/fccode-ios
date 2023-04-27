//
//  ResetPasswordView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct ResetPasswordView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            VStack (spacing: 0.0){
                EntryLogo()
                
                Spacer()
                
                HStack {
                    Text("Reset\nPassword")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                    .frame(width: 183)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                VStack (spacing: 20){
                    PrimaryInputBar(hint: "Please enter new password", isDisable: false, hasButton: false)
                    
                    PrimaryInputBar(hint: "Confirm password", isDisable: false, hasButton: false)
                }
                .padding(.horizontal, 24)
                .padding(.top, 30)
                .padding(.bottom, 10)
                
                HStack {
                    VStack (alignment: .leading, spacing: 6.0){
                        InputHelper(isSatisfied: .constant(true), label: "At least 8 characters")
                        InputHelper(isSatisfied: .constant(true), label: "At least one upper & one lowercase")
                        InputHelper(isSatisfied: .constant(true), label: "At least one number & one symbol")
                        InputHelper(isSatisfied: .constant(false), label: "Match with password")
                    }
                    .padding(.horizontal, 38.67)
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 122)
                
                
                Button {
                    print("email check")
                } label: {
                    Text("Done")
                }
                .buttonStyle(PrimaryButton())
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
        .preferredColorScheme(.light)
    }
    
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
