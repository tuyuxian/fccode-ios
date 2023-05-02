//
//  SignUpNameView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpNameView: View {
    @ObservedObject var user: EntryViewModel
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            
            VStack {
                EntryLogo()
                    .padding(.top, 5)
                    .padding(.bottom, 55)

                
                SignUpProcessBar(status: 1)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 24)
                
                
                HStack {
                    Text("Tell us about your...")
                        .fontTemplate(.h3Bold)
                        .foregroundColor(Color.text)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                HStack {
                    Text("Name")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 4)
                
                Spacer()
                    .frame(height: 18)
                
                PrimaryInputBar(value: $user.username, hint: "Please enter your name", isDisable: false, hasButton: false, isQualified: $user.isQualified)
                    .padding(.horizontal, 24)
                
                HStack {
<<<<<<< HEAD
                    InputHelper(iconName: "CheckCircleBased", label: "At least 2 and less than 30 characters", textcolor: user.username.count >= 2 && user.username.count <= 30 ? Color.text : Color.surface1, imageColor: user.username.count >= 2 && user.username.count <= 30 ? Color.text : Color.surface1)
=======
                    InputHelper(isSatisfied: .constant(false), label: "2-30 characters")
>>>>>>> release
                    
                    Spacer()
                }
                .padding(.horizontal, 38.67)
                .padding(.vertical, 8)
                
                Spacer()
                
                Button {
                    user.username.count >= 2 && user.username.count <= 30 ? user.isQualified = true : nil
                } label: {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButton(labelColor: user.username.count >= 2 && user.username.count <= 30 ? Color.text : Color.white, buttonColor: user.username.count >= 2 && user.username.count <= 30 ? Color.yellow100 : Color.surface2))
                .padding(.horizontal, 24)
                .padding(.bottom, 50)

                
            }
            .navigationDestination(isPresented: $user.isQualified) {
                SignUpBirthdateView(user: user)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    VStack(alignment: .center) {
                        NavigationBarBackButton()
                    }
                    .frame(height: 40)
                    .padding(.top, 24)
                    .padding(.leading, 14))
            .onDisappear{
                user.isQualified = false
            }
            
            
        }

    }
}

struct SignUpNameView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNameView(user: EntryViewModel())
    }
}


