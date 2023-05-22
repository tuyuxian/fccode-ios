//
//  SettingsResetPasswordView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsResetPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var vm: ProfileViewModel
    /// Flag for password validation
    @State private var isNewPasswordValid: Bool = true
    /// Flag for loading state
    @State private var isLoading: Bool = false
    
    private func buttonOnTap() {
        guard vm.isPasswordValid(str: vm.newPassword) &&
                vm.newPassword == vm.newPasswordConfirmed
        else {
            isNewPasswordValid = false
            return
        }
        isNewPasswordValid = true
        vm.currentPassword = ""
        vm.newPassword = ""
        vm.newPasswordConfirmed = ""
        presentationMode.wrappedValue.dismiss()
    }
        
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Settings",
            childTitle: "Password",
            showSaveButton: $vm.isNewPasswordSatisfied,
            isLoading: $isLoading,
            action: buttonOnTap
        ) {
            Box {
                VStack(
                    alignment: .leading,
                    spacing: 20
                ) {
                    vm.user.password != ""
                    ? PrimaryInputBar(
                        input: .password,
                        value: $vm.currentPassword,
                        hint: "Enter current password",
                        isValid: $isNewPasswordValid
                    )
                    .onChange(of: vm.currentPassword) { _ in
                        // TODO(Sam): check current password
                    }
                    : nil
                    
                    PrimaryInputBar(
                        input: .password,
                        value: $vm.newPassword,
                        hint: "Enter new password",
                        isValid: $isNewPasswordValid
                    )
                    .onChange(of: vm.newPassword) { password in
                        vm.isNewPasswordLengthSatisfied =
                            vm.checkLength(str: password)
                        vm.isNewPasswordUpperAndLowerSatisfied =
                            vm.checkUpper(str: password) &&
                            vm.checkLower(str: password)
                        vm.isNewPasswordNumberAndSymbolSatisfied =
                            vm.checkNumber(str: password) &&
                            vm.checkSymbols(str: password)
                        vm.isNewPasswordMatched =
                            !vm.newPassword.isEmpty &&
                            !password.isEmpty &&
                            vm.newPasswordConfirmed == password
                        vm.isNewPasswordSatisfied =
                            vm.isNewPasswordLengthSatisfied &&
                            vm.isNewPasswordUpperAndLowerSatisfied &&
                            vm.isNewPasswordNumberAndSymbolSatisfied &&
                            vm.isNewPasswordMatched
                    }
                        
                    PrimaryInputBar(
                        input: .password,
                        value: $vm.newPasswordConfirmed,
                        hint: "Confirm new password",
                        isValid: $isNewPasswordValid
                    )
                    .onChange(of: vm.newPasswordConfirmed) { password in
                        vm.isNewPasswordMatched =
                            !vm.newPassword.isEmpty &&
                            !password.isEmpty &&
                            vm.newPassword == password
                        vm.isNewPasswordSatisfied =
                            vm.isNewPasswordLengthSatisfied &&
                            vm.isNewPasswordUpperAndLowerSatisfied &&
                            vm.isNewPasswordNumberAndSymbolSatisfied &&
                            vm.isNewPasswordMatched
                    }
                
                    VStack(
                        alignment: .leading,
                        spacing: 6.0
                    ) {
                        InputHelper(
                            isSatisfied: $vm.isNewPasswordLengthSatisfied,
                            label: "Password should be 8 to 36 characters",
                            type: .info
                        )
                        
                        InputHelper(
                            isSatisfied: $vm.isNewPasswordUpperAndLowerSatisfied,
                            label: "At least 1 uppercase & 1 lowercase",
                            type: .info
                        )
                        
                        InputHelper(
                            isSatisfied: $vm.isNewPasswordNumberAndSymbolSatisfied,
                            label: "At least 1 number & 1 symbol",
                            type: .info
                        )
                        
                        InputHelper(
                            isSatisfied: $vm.isNewPasswordMatched,
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
