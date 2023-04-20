//
//  SignUpGenderView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpGenderView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            
            VStack {
                EntryLogo()
                
                Spacer()
                
                HStack {
                    Text("Tell us about your...")
                        .fontTemplate(.h3Medium)
                    .foregroundColor(Color.textHelper)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                HStack {
                    Text("Gender")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                
                HStack {
                    VStack (alignment: .leading){
                        RadioButton(label: "Male")
                        RadioButton(label: "Female")
                        RadioButton(label: "Non-binary")
                        RadioButton(label: "Prefer not to say")
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 32)
                
                
                
                Spacer()
                    .frame(height: 170)
                
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

struct SignUpGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpGenderView()
    }
}


