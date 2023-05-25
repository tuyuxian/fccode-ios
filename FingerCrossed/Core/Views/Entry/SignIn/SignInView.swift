//
//  SignInView.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//  Modified by Sam on 5/5/23.
//

import SwiftUI

struct SignInView: View, KeyboardReadable {
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Flag for password validation
    @State private var isPasswordValid: Bool = true
    /// Flag for button tap
    @State private var isStatisfied: Bool = false
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
        vm.transition = .forward
        vm.switchView = .password
    }
    
    private func forgotPasswordOnTap() {
        vm.transition = .forward
        vm.switchView = .resetPassword
    }
    
    private func backToEntry() {
        vm.transition = .backward
        vm.switchView = .onboarding
        vm.email = ""
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
                        vm.switchView = .onboarding
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
                
                VStack(spacing: 30) {
                    Text("Glad to\nSee You Back")
                        .fontTemplate(.bigBoldTitle)
                        .foregroundColor(Color.text)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .frame(height: 100)
                    
                    VStack(
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

                        // TODO(Sam): handle wrong password
                        !isPasswordValid
                        ? ErrorHelper()
                            .padding(.leading, 16)
                            .padding(.vertical, -10)
                        : nil
                        
                        PrimaryButton(
                            label: "Continue",
                            action: passwordOnSubmit,
                            isTappable: $isStatisfied,
                            isLoading: $isLoading
                        )
                    }
                    
                    HStack(spacing: 10) {
                        VStack {
                            Divider()
                                .overlay(Color.surface1)
                        }
                        
                        Text("or")
                            .fontTemplate(.pMedium)
                            .foregroundColor(Color.text)
                        
                        VStack {
                            Divider()
                                .overlay(Color.surface1)
                        }
                    }
                    
                    VStack(spacing: 16) {
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
            .ignoresSafeArea(.keyboard, edges: .all)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(
            vm: EntryViewModel()
        )
    }
}

private struct ErrorHelper: View {
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
            
            InputHelper(
                isSatisfied: .constant(false),
                label: "Password should be 8 to 36 characters",
                type: .error
            )
        }
    }
}
