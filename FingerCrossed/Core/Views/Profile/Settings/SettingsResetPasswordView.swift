//
//  SettingsResetPasswordView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsResetPasswordView: View {
    /// View controller
    @Environment(\.dismiss) var dismiss
    /// Banner
    @EnvironmentObject var bm: BannerManager
    /// Init reset password view model
    @StateObject var vm: ResetPasswordViewModel
    
    private func save() {
        Task {
            await vm.save()
            guard vm.state == .complete else { return }
            dismiss()
        }
    }
    
    init(
        hasPassword: Bool
    ) {
        print("[Settings Reset Password] view init")
        _vm = StateObject(wrappedValue: ResetPasswordViewModel(hasPassword: hasPassword))
    }
        
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Settings",
            childTitle: "Password",
            showSaveButton: $vm.isNewPasswordSatisfied,
            isLoading: .constant(vm.state == .loading),
            action: save
        ) {
            Box {
                VStack(
                    alignment: .leading,
                    spacing: 20
                ) {
                    vm.hasPassword
                    ? PrimaryInputBar(
                        input: .password,
                        value: $vm.currentPassword,
                        hint: "Enter current password",
                        isValid: .constant(
                            vm.isNewPasswordValid &&
                            vm.isCurrentPasswordMatched
                        )
                    )
                    : nil
                    
                    !vm.isCurrentPasswordMatched
                    ? SettingsResetPasswordErrorHelper()
                        .padding(.top, -10)
                        .padding(.leading, 16)
                    : nil
                    
                    PrimaryInputBar(
                        input: .password,
                        value: $vm.newPassword,
                        hint: "Enter new password",
                        isValid: $vm.isNewPasswordValid
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
                        isValid: $vm.isNewPasswordValid
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
                .padding(.horizontal, 24)
                .padding(.top, 30)
                
                Spacer()
            }
            .onChange(of: vm.state) { state in
                if state == .error {
                    bm.pop(
                        title: vm.toastMessage,
                        type: vm.toastType
                    )
                    vm.state = .none
                }
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
}

struct SettingsResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsResetPasswordView(
            hasPassword: true
        )
        .environmentObject(BannerManager())
    }
}

private struct SettingsResetPasswordErrorHelper: View {
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 6
        ) {
            HStack(
                alignment: .top,
                spacing: 6
            ) {
                Image("ErrorCircleRed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                VStack(
                    alignment: .leading,
                    spacing: 0
                ) {
                    Text("Hmm, it doesn’t match your current password.\nPlease try again.")
                        .fontTemplate(.noteMedium)
                        .foregroundColor(Color.warning)
                }
            }
        }
    }
}
