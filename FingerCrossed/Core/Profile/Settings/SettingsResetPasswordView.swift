//
//  SettingsResetPasswordView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsResetPasswordView: View {
    @State var hasPassword: Bool = true
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Settings", childTitle: "Password") {
            Box {
                VStack(alignment: .leading, spacing: 20.0) {
                    hasPassword
                    ? VStack(alignment: .leading, spacing: 6.0) {
                        Text("Current Password")
                            .fontTemplate(.pMedium)
                            .foregroundColor(.text)
//                        PrimaryInputBar(hint: "Please enter your password", isDisable: false, hasButton: false)
                    }
                    : nil
                    
                    VStack(alignment: .leading, spacing: 6.0) {
                        Text("New Password")
                            .fontTemplate(.pMedium)
                            .foregroundColor(.text)
//                        PrimaryInputBar(hint: "Please enter new password", isDisable: false, hasButton: false)
                    }
                    
                    VStack(alignment: .leading, spacing: 6.0) {
                        Text("Comfirm Password")
                            .fontTemplate(.pMedium)
                            .foregroundColor(.text)
//                        PrimaryInputBar(hint: "Confirm new password", isDisable: false, hasButton: false)
                    }
            
                }
                .padding(EdgeInsets(top: 30, leading: 24, bottom: 0, trailing: 24))
                
                HStack {
                    VStack (alignment: .leading, spacing: 6.0) {
                        InputHelper(isSatisfied: .constant(true), label: "At least 8 characters")
                        InputHelper(isSatisfied: .constant(true), label: "At least one upper & one lowercase")
                        InputHelper(isSatisfied: .constant(true), label: "At least one number & one symbol")
                        InputHelper(isSatisfied: .constant(false), label: "Match with password")
                    }
                    .padding(.horizontal, 24) //check position
                    
                    Spacer()
                }
                .padding(.vertical, 10)
                
                Spacer()
            }
        }
    }
    
    struct SettingsResetPasswordView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsResetPasswordView()
        }
    }
    
}
