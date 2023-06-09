//
//  ResetPasswordView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct ResetPasswordView: View, KeyboardReadable {
    /// Global banner
    @EnvironmentObject var bm: BannerManager
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Flag for password validation
    @State private var isPasswordValid: Bool = true
    /// Flag for keyboard signal
    @State private var isKeyboardShowUp: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Handler for button on tap
    private func buttonOnTap() {
        self.endTextEditing()
        guard vm.isPasswordValid(str: vm.newPassword) &&
                vm.newPassword == vm.newPasswordConfirmed
        else {
            isPasswordValid = false
            return
        }
        isPasswordValid = true
        isLoading.toggle()
        Task {
            do {
                let success = try await GraphAPI.resetPassword(
                    email: vm.user.email,
                    password: vm.newPassword
                )
                guard success else {
                    isLoading.toggle()
                    bm.pop(
                        title: "Something went wrong.",
                        type: .error
                    )
                    return
                }
                isLoading.toggle()
                bm.pop(
                    title: "All Set! You’ve successfully reset password",
                    type: .info
                )
                vm.transition = .forward
                vm.switchView = .password
                vm.newPassword = ""
                vm.newPasswordConfirmed = ""
            } catch {
                print(error.localizedDescription)
                bm.pop(
                    title: "Something went wrong.",
                    type: .error
                )
            }
        }
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
                alignment: .center,
                spacing: 0
            ) {
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
                    
                    VStack(alignment: .leading, spacing: 6.0) {
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
        .onTapGesture {
            withAnimation(
                .easeInOut(
                    duration: 0.16
                )
            ) {
                UIApplication.shared.closeKeyboard()
            }
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
