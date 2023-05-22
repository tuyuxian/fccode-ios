//
//  ResetPasswordView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct ResetPasswordView: View, KeyboardReadable {
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Flag for password validation
    @State private var isPasswordValid: Bool = true
    /// Flag for keyboard signal
    @State private var isKeyboardShowUp: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false
    
    private func buttonOnTap() {
        guard vm.isPasswordValid(str: vm.newPassword) &&
                vm.newPassword == vm.newPasswordConfirmed
        else {
            isPasswordValid = false
            return
        }
        isPasswordValid = true
        vm.transition = .forward
        vm.switchView = .resetPasswordEmailCheck
        vm.newPassword = ""
        vm.newPasswordConfirmed = ""
    }

    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .center,
                vertical: .top
            )
        ) {
            Color.background.ignoresSafeArea(.all)
            
            VStack(
                alignment: .leading,
                spacing: 0
            ) {
                HStack(
                    alignment: .center,
                    spacing: 92
                ) {
                    Button {
                        vm.transition = .backward
                        vm.switchView = .password
                    } label: {
                        Image("ArrowLeftBased")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.leading, -8) // 16 - 24
                                        
                    EntryLogo()
                }
                .padding(.top, 5)
                .padding(.bottom, 55)
                
                !isKeyboardShowUp
                ? Text("Reset\nPassword")
                    .fontTemplate(.bigBoldTitle)
                    .foregroundColor(Color.text)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .frame(height: 100)
                    .padding(.bottom, 30)
                : nil

                LazyVStack(
                    alignment: .leading,
                    spacing: 20
                ) {
                    PrimaryInputBar(
                        input: .password,
                        value: $vm.newPassword,
                        hint: "Enter new password",
                        isValid: $isPasswordValid
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
                    .onReceive(keyboardPublisher) { val in
                        isKeyboardShowUp = val
                    }
                    
                    PrimaryInputBar(
                        input: .password,
                        value: $vm.newPasswordConfirmed,
                        hint: "Confirm new password",
                        isValid: $isPasswordValid
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
                    .onReceive(keyboardPublisher) { val in
                        isKeyboardShowUp = val
                    }
                    
                    LazyVStack(alignment: .leading, spacing: 6.0) {
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
                            label: "New passwords are matched",
                            type: .info
                        )
                    }
                    .padding(.top, -10)
                    .padding(.leading, 16)
                }
                
                Spacer()
                    .ignoresSafeArea(.keyboard)
                
                PrimaryButton(
                    label: "Reset Password",
                    action: buttonOnTap,
                    isTappable: $vm.isNewPasswordSatisfied,
                    isLoading: $isLoading
                )
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(
            vm: EntryViewModel()
        )
    }
}
