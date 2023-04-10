//
//  SignInView.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//

import SwiftUI

struct SignInView: View {
    var userAccount : String = "Testing123@gmail.com"
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            VStack (spacing: 0.0){
                EntryLogo()
                
                Spacer()
                
                HStack {
                    Text("Find Your\nPerfect match")
                        .foregroundColor(.text)
                        .font(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                Spacer()
                    .frame(height: 30)
                
                VStack (spacing: 20){
                    PrimaryInputBar(hint: userAccount, isDisable: true, hasButton: false)
                    
                    PrimaryInputBar(hint: "Password", isDisable: false, hasButton: true)
                }
                .padding(.horizontal, 24)
                
                DividerWithLabel()
                    .padding(.vertical, 30)
                
                VStack (spacing: 20){
                    ViewLink(view: ResetPasswordEmailCheckView())
                    
                    ViewLink(view: EntryView(), label: "Log in with Social Media Account")
                }
                
                Spacer()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
