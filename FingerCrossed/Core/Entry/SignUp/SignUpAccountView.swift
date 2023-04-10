//
//  SignUpAccountView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpAccountView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            VStack (spacing: 0.0){
                EntryLogo()
                
                Spacer()
                
                HStack {
                    Text("Welcome to\nJoin us")
                        .foregroundColor(.text)
                        .font(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
                
                VStack (spacing: 20){
                    PrimaryInputBar(hint: "Testing123@gmail.com", isDisable: true, hasButton: false)
                    
                    PrimaryInputBar(hint: "Please enter your password", isDisable: false, hasButton: false)
                    
                    PrimaryInputBar(hint: "Confirm password", isDisable: false, hasButton: false)
                }
                .padding(.horizontal, 24)
                
                HStack {
                    VStack (alignment: .leading, spacing: 6.0){
                        InputHelper()
                        
                        InputHelper(label: "At least one upper & one lowercase")
                        
                        InputHelper(label: "At least one number & symbol")
                        
                        InputHelper(label: "Match with password")
                    }
                    .padding(.horizontal, 38.67)
                    
                    Spacer()
                }
                .padding(.vertical, 20)
                
                Button {
                    print("Continue")
                } label: {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButton())
                .padding(.horizontal, 24)
                
                ViewLink(view: EntryView(), label: "Back to login")
                    .padding(.top, 30)
                
                Spacer()
            }
        }
    }
}

struct SignUpAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpAccountView()
    }
}
