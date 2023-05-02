//
//  ResetPasswordView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct ResetPasswordView: View {
    @ObservedObject var user: EntryViewModel
    @State private var showEntryView: Bool = false
    @State var newPassword: String = ""
    @State var newPasswordConfirmed: String = ""
    
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            VStack (spacing: 0.0){
                EntryLogo()
                
                Spacer()
                    .frame(height: 78)
                
                HStack {
                    Text("Reset\nPassword")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                VStack (spacing: 20){
                    PrimaryInputBar(value: $newPassword, hint: "Please enter new password", isDisable: false, hasButton: false, isPassword: true, isQualified: $user.isQualified)
                    
                    PrimaryInputBar(value: $newPasswordConfirmed, hint: "Confirm new password", isDisable: false, hasButton: false, isPassword: true, isQualified: $user.isQualified)
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
                
                
                Button(action: {
                    showEntryView = true
                }, label: {
                    Text("Done")
                })
                .buttonStyle(PrimaryButton())
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
        
            }
        }
        .preferredColorScheme(.light)
        .fullScreenCover(isPresented: $showEntryView) {
            EntryView()
        }
    }
    
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(user: EntryViewModel())
    }
}
