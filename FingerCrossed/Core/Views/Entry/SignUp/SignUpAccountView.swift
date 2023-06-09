//
//  SignUpAccountView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpAccountView: View, KeyboardReadable {
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
        guard vm.isPasswordValid(str: vm.password) else {
            isPasswordValid = false
            return
        }
        isPasswordValid = true
        vm.user.password = vm.password
        vm.transition = .forward
        vm.switchView = .name
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
                        vm.switchView = .email
                    } label: {
                        Image("ArrowLeft")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.leading, -8) // 16 - 24
                    
                    EntryLogo()
                }
                .padding(.top, 5)
                .padding(.bottom, 55)
                
                !isKeyboardShowUp
                ? Text("Welcome to\nJoin us")
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
                        input: .text,
                        value: $vm.user.email,
                        isValid: .constant(true),
                        isDisable: true
                    )
                    
                    PrimaryInputBar(
                        input: .password,
                        value: $vm.password,
                        hint: "Enter password",
                        isValid: $isPasswordValid
                    )
                    .onChange(of: vm.password) { password in
                        vm.isAccountPasswordLengthSatisfied =
                        vm.checkLength(str: password)
                        vm.isAccountPasswordUpperAndLowerSatisfied =
                        vm.checkUpper(str: password) &&
                        vm.checkLower(str: password)
                        vm.isAccountPasswordNumberAndSymbolSatisfied =
                        vm.checkNumber(str: password) &&
                        vm.checkSymbols(str: password)
                        vm.isAccountPasswordMatched =
                        !vm.password.isEmpty &&
                        !password.isEmpty &&
                        vm.passwordConfirmed == password
                        vm.isAccountPasswordSatisfied =
                        vm.isAccountPasswordLengthSatisfied &&
                        vm.isAccountPasswordUpperAndLowerSatisfied &&
                        vm.isAccountPasswordNumberAndSymbolSatisfied &&
                        vm.isAccountPasswordMatched
                    }
                    .onReceive(keyboardPublisher) { val in
                        isKeyboardShowUp = val
                    }
                    
                    PrimaryInputBar(
                        input: .password,
                        value: $vm.passwordConfirmed,
                        hint: "Confirm password",
                        isValid: $isPasswordValid
                    )
                    .onChange(of: vm.passwordConfirmed) { password in
                        vm.isAccountPasswordMatched =
                        !vm.password.isEmpty &&
                        !password.isEmpty &&
                        vm.password == password
                        vm.isAccountPasswordSatisfied =
                        vm.isAccountPasswordLengthSatisfied &&
                        vm.isAccountPasswordUpperAndLowerSatisfied &&
                        vm.isAccountPasswordNumberAndSymbolSatisfied &&
                        vm.isAccountPasswordMatched
                    }
                    .onReceive(keyboardPublisher) { val in
                        isKeyboardShowUp = val
                    }
                    
                    VStack(
                        alignment: .leading,
                        spacing: 6.0
                    ) {
                        InputHelper(
                            isSatisfied: $vm.isAccountPasswordLengthSatisfied,
                            label: "Password should be 8 to 36 characters",
                            type: .info
                        )
                        
                        InputHelper(
                            isSatisfied: $vm.isAccountPasswordUpperAndLowerSatisfied,
                            label: "At least 1 uppercase & 1 lowercase",
                            type: .info
                        )
                        
                        InputHelper(
                            isSatisfied: $vm.isAccountPasswordNumberAndSymbolSatisfied,
                            label: "At least 1 number & 1 symbol",
                            type: .info
                        )
                        
                        InputHelper(
                            isSatisfied: $vm.isAccountPasswordMatched,
                            label: "Passwords are matched",
                            type: .info
                        )
                    }
                    .padding(.top, -10)
                    .padding(.leading, 16)
                }
                
                Spacer()
                
                PrimaryButton(
                    label: "Continue",
                    action: buttonOnTap,
                    isTappable: $vm.isAccountPasswordSatisfied,
                    isLoading: .constant(false)
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

struct SignUpAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpAccountView(
            vm: EntryViewModel()
        )
    }
}
