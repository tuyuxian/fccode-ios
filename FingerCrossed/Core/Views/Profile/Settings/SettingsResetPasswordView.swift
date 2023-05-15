//
//  SettingsResetPasswordView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsResetPasswordView: View {
    
    @ObservedObject var vm: ProfileViewModel
        
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Settings",
            childTitle: "Password"
        ) {
            Box {
                VStack(
                    alignment: .leading,
                    spacing: 20
                ) {
                    vm.user.password != ""
                    ? VStack(alignment: .leading, spacing: 6) {
                        PrimaryInputBar(
                            input: .password,
                            value: .constant(""),
                            hint: "Please enter current password"
                        )
                    }
                    : nil
                    
                    VStack(alignment: .leading, spacing: 6) {
                        PrimaryInputBar(
                            input: .password,
                            value: .constant(""),
                            hint: "Please enter new password"
                        )
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        PrimaryInputBar(
                            input: .password,
                            value: .constant(""),
                            hint: "Confirm new password"
                        )
                    }
                    
                    VStack(
                        alignment: .leading,
                        spacing: 6.0
                    ) {
                        InputHelper(
                            isSatisfied: .constant(false),
                            label: "Password should be 8 to 36 characters",
                            type: .info
                        )
                        
                        InputHelper(
                            isSatisfied: .constant(false),
                            label: "At least 1 uppercase & 1 lowercase",
                            type: .info
                        )
                        
                        InputHelper(
                            isSatisfied: .constant(false),
                            label: "At least 1 number & 1 symbol",
                            type: .info
                        )
                        
                        InputHelper(
                            isSatisfied: .constant(false),
                            label: "Passwords are matched",
                            type: .info
                        )
                    }
                    .padding(.top, -10)
                    .padding(.leading, 16)
                }
                .padding(
                    EdgeInsets(
                        top: 30,
                        leading: 24,
                        bottom: 0,
                        trailing: 24
                    )
                )
                
                Spacer()
            }
        }
    }
    
    struct SettingsResetPasswordView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsResetPasswordView(
                vm: ProfileViewModel()
            )
        }
    }
}
