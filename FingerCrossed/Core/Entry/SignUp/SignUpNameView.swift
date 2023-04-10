//
//  SignUpNameView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpNameView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            
            VStack {
                EntryLogo()
                
                Spacer()
                
                HStack {
                    Text("Tell us about your...")
                        .font(.h3Medium)
                    .foregroundColor(Color.textHelper)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 30)
                
                HStack {
                    Text("Name")
                        .foregroundColor(.text)
                    .font(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                
                Spacer()
                    .frame(height: 18)
                
                PrimaryInputBar(hint: "Please enter your name", isDisable: false, hasButton: false)
                    .padding(.horizontal, 24)
                
                HStack {
                    InputHelper(iconName: "CheckCircleBased", label: "2-30 characters")
                    
                    Spacer()
                }
                .padding(.horizontal, 38.67)
                .padding(.vertical, 8)
                
                Spacer()
                    .frame(height: 254)
                
                Button {
                    print("Continue")
                } label: {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButton())
                .padding(.horizontal, 24)
                
                Spacer()
                
            }
            
            
        }
    }
}

struct SignUpNameView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNameView()
    }
}
