//
//  ResetPasswordView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct ResetPasswordView: View, KeyboardReadable {
    // Observed entry view model
    @ObservedObject var vm: EntryViewModel
    // Flag for password validation
    @State var isPasswordValid: Bool = true
    // Flag for button tappable
    @State var isStatisfied: Bool = false
    // Flags for input helpers
    @State var isLengthStatisfied: Bool = false
    @State var isUpperAndLowerStatisfied: Bool = false
    @State var isNumberAndSymbolStatisfied: Bool = false
    @State var isNewPasswordMatched: Bool = false
    // Flag for keyboard signal
    @State var isKeyboardShowUp: Bool = false
    
    private func buttonOnTap() {
        guard vm.isNewPasswordValid() else {
            isPasswordValid = false
            return
        }
        isPasswordValid = true
        vm.transition = .forward
        vm.switchView = .resetPasswordEmailCheck
    }

    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .center,
                vertical: .top
            )
        ) {
            Color.background.ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                EntryLogo()
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

                VStack(
                    alignment: .leading,
                    spacing: 20
                ) {
                    PrimaryInputBar(
                        input: .password,
                        value: $vm.newPassword,
                        hint: "Please enter new password"
                    )
                    .onChange(of: vm.newPassword) { password in
                        isLengthStatisfied = vm.checkLength(str: password)
                        isUpperAndLowerStatisfied =
                            vm.checkUpper(str: password) &&
                            vm.checkLower(str: password)
                        isNumberAndSymbolStatisfied =
                            vm.checkNumber(str: password) &&
                            vm.checkSymbols(str: password)
                        isStatisfied =
                            isLengthStatisfied &&
                            isUpperAndLowerStatisfied &&
                            isNumberAndSymbolStatisfied &&
                            isNewPasswordMatched
                    }
                    .onReceive(keyboardPublisher) { val in
                        isKeyboardShowUp = val
                    }
                    
                    PrimaryInputBar(
                        input: .password,
                        value: $vm.newPasswordConfirmed,
                        hint: "Confirm new password"
                    )
                    .onChange(of: vm.newPasswordConfirmed) { password in
                        isNewPasswordMatched =
                            !vm.newPassword.isEmpty &&
                            !password.isEmpty &&
                            vm.newPassword == password
                        isStatisfied =
                            isLengthStatisfied &&
                            isUpperAndLowerStatisfied &&
                            isNumberAndSymbolStatisfied &&
                            isNewPasswordMatched
                    }
                    .onReceive(keyboardPublisher) { val in
                        isKeyboardShowUp = val
                    }
                    
                    VStack(alignment: .leading, spacing: 6.0) {
                        InputHelper(
                            isSatisfied: $isLengthStatisfied,
                            label: "Password should be 8 to 36 characters",
                            type: .info
                        )
                        
                        InputHelper(
                            isSatisfied: $isUpperAndLowerStatisfied,
                            label: "At least 1 uppercase & 1 lowercase",
                            type: .info
                        )
                        
                        InputHelper(
                            isSatisfied: $isNumberAndSymbolStatisfied,
                            label: "At least 1 number & 1 symbol",
                            type: .info
                        )
                        
                        InputHelper(
                            isSatisfied: $isNewPasswordMatched,
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
                    label: "Update Password",
                    action: buttonOnTap,
                    isTappable: $isStatisfied
                )
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(vm: EntryViewModel())
    }
}
