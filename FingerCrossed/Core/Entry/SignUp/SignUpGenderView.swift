//
//  SignUpGenderView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpGenderView: View {
    @ObservedObject var user: EntryViewModel
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            
            VStack {
                EntryLogo()
                    .padding(.top, 5)
                    .padding(.bottom, 55)
                
                SignUpProcessBar(status: 3)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                
                HStack {
                    Text("Tell us about your...")
                        .fontTemplate(.h3Bold)
                        .foregroundColor(Color.text)
                    
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
<<<<<<< HEAD
                .padding(.top, 4)

                RadioButtonGenderGroup { selected in
                    user.gender = Gender.allCases.first { gender in
                        gender.rawValue == selected
=======
                .padding(.vertical, 12)
                
                HStack {
                    VStack (alignment: .leading){
                        RadioButtonRow(label: "Male")
                        RadioButtonRow(label: "Female")
                        RadioButtonRow(label: "Non-binary")
                        RadioButtonRow(label: "Prefer not to say")
>>>>>>> release
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 30)
                
                Spacer()
                
                Button {
                    user.gender != nil ? user.isQualified = true : nil
                } label: {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButton(labelColor: user.gender != nil ? Color.text: Color.white, buttonColor: user.gender != nil ? Color.yellow100 : Color.surface2))
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
                
            }
            .navigationDestination(isPresented: $user.isQualified) {
                SignUpEthnicityView(user: user)
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

struct SignUpGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpGenderView(user: EntryViewModel())
    }
}


