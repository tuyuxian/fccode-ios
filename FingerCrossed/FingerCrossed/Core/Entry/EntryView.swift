//
//  EntryView.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//

import SwiftUI

struct EntryView: View {
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
                
                PrimaryInputBar(isDisable: false, hasButton: true)
                    .padding(.horizontal, 24)
                
                Spacer()
                    .frame(height: 30)
                
                DividerWithLabel()
                
                Spacer()
                    .frame(height: 30)
                
                
                VStack (spacing: 20){
                    Button {
                        print("facebook")
                    } label: {
                        Label("Continue with Facebook", image: "Fb")
                    }
                    .buttonStyle(SSOButton())
                    .padding(.horizontal, 24)
                    
                    Button {
                        print("google")
                    } label: {
                        Label("Continue with Google", image: "Google")
                    }
                    .buttonStyle(SSOButton(labelColor: Color.text, buttonColor: Color.white))
                    .padding(.horizontal, 24)
                    
                    Button {
                        print("yeah")
                    } label: {
                        Label("Continue with Apple", image: "Apple")
                    }
                    .buttonStyle(SSOButton(labelColor: Color.white, buttonColor: Color.text))
                    .padding(.horizontal, 24)
                }
                
                Spacer()
                
                
                
                
            }
        }
        
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
