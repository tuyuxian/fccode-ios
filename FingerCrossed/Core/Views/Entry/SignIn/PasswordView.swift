//
//  PasswordView.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//  Modified by Sam on 5/5/23.
//

import SwiftUI

struct PasswordView: View, KeyboardReadable {
    /// Observed global view model
    @ObservedObject var global: GlobalViewModel
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Flag for password validation
    @State private var isPasswordValid: Bool = true
    /// Flag for keyboard signal
    @State private var isKeyboardShowUp: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false

    private func passwordOnSubmit() {
        guard vm.isPasswordValid() else {
            isPasswordValid = false
            return
        }
        isPasswordValid = true
        global.isLogin = true
        global.viewState = .main
    }
    
    private func forgotPasswordOnTap() {
        vm.transition = .forward
        vm.switchView = .resetPassword
    }
    
    private func backToEntry() {
        vm.transition = .backward
        vm.switchView = .email
        vm.email = ""
        vm.password = ""
        vm.isEmailSatisfied = false
    }
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .center,
                vertical: .top
            )
        ) {
            Color.background.ignoresSafeArea(.all)
            
            ScrollView {
                LazyVStack(
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
                            Image("ArrowLeftBased")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        .padding(.leading, -8) // 16 - 24
                        
                        EntryLogo()
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 55)
                    
                    LazyVStack(spacing: 30) {
                        Text("Glad to\nSee You Back")
                            .fontTemplate(.bigBoldTitle)
                            .foregroundColor(Color.text)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            .frame(height: 100)
                        
                        LazyVStack(
                            alignment: .leading,
                            spacing: 20
                        ) {
                            PrimaryInputBar(
                                input: .password,
                                value: $vm.password,
                                hint: "Password",
                                isValid: $isPasswordValid
                            )
                            .onReceive(keyboardPublisher) { val in
                                isKeyboardShowUp = val
                            }
                            .onChange(of: vm.password) { val in
                                vm.isPasswordSatisfied = val.count > 0
                            }
                            
                            !isPasswordValid
                            ? ErrorHelper(vm: vm)
                                .padding(.leading, 16)
                                .padding(.vertical, -10)
                            : nil
                            
                            PrimaryButton(
                                label: "Continue",
                                action: passwordOnSubmit,
                                isTappable: $vm.isPasswordSatisfied,
                                isLoading: $isLoading
                            )
                        }
                        
                        HStack(spacing: 10) {
                            LazyVStack {
                                Divider()
                            }
                            
                            Text("or")
                                .fontTemplate(.pMedium)
                                .foregroundColor(Color.text)
                            
                            LazyVStack {
                                Divider()
                            }
                        }
                        
                        LazyVStack(spacing: 16) {
                            Button {
                                forgotPasswordOnTap()
                            } label: {
                                Text("Forgot password")
                                    .fontTemplate(.pMedium)
                                    .foregroundColor(Color.gold)
                            }
                            
                            Button {
                                backToEntry()
                            } label: {
                                Text("Continue with social sign-in")
                                    .fontTemplate(.pMedium)
                                    .foregroundColor(Color.gold)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
            .scrollDisabled(true)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView(
            global: GlobalViewModel(),
            vm: EntryViewModel()
        )
    }
}

private struct ErrorHelper: View {
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 6
        ) {
            InputHelper(
                isSatisfied: .constant(false),
                label: "Please enter a valid password",
                type: .error
            )
            
            vm.checkLength(str: vm.password)
            ? nil
            : InputHelper(
                isSatisfied: .constant(false),
                label: "Password should be 8 to 36 characters",
                type: .error
            )
            
            vm.checkUpper(str: vm.password) && vm.checkLower(str: vm.password)
            ? nil
            : InputHelper(
                isSatisfied: .constant(false),
                label: "At least 1 uppercase and 1 lowercase",
                type: .error
            )
            
            vm.checkNumber(str: vm.password) && vm.checkSymbols(str: vm.password)
            ? nil
            : InputHelper(
                isSatisfied: .constant(false),
                label: "At least 1 number and 1 symbol",
                type: .error
            )
            
            // TODO(Sam): handle wrong password
//            InputHelper(
//                isSatisfied: .constant(false),
//                label: "Wrong password",
//                type: .error
//            )
        }
    }
}
