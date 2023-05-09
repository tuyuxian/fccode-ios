//
//  SignInView.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//  Modified by Sam on 5/5/23.
//

import SwiftUI

struct SignInView: View {
    // Observed entry view model
    @ObservedObject var vm: EntryViewModel
    // Flag for password validation
    @State var isPasswordValid: Bool = true
    
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
            VStack(spacing: 0) {
                EntryLogo()
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
                            input: .text,
                            value: $vm.email,
                            isDisable: true
                        )
                        
                        PrimaryInputBar(
                            input: .password,
                            value: $vm.password,
                            hint: "Password",
                            action: passwordOnSubmit
                        )
                        .onSubmit {
                            passwordOnSubmit()
                        }
                        // TODO(Sam): handle wrong password
                        !isPasswordValid
                        ? ErrorHelper()
                        : nil
                    }
                    
                    HStack(spacing: 10) {
                        VStack {
                            Divider()
                        }
                        
                        Text("or")
                            .fontTemplate(.pMedium)
                            .foregroundColor(Color.text)
                        
                        VStack {
                            Divider()
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
                            Text("Log in with SSO")
                                .fontTemplate(.pMedium)
                                .foregroundColor(Color.gold)
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(vm: EntryViewModel())
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
