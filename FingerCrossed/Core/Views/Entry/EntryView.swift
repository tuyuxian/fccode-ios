//
//  EntryView.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//  Modified by Sam on 5/5/23.
//

import SwiftUI
import AuthenticationServices

struct EntryView: View {
    // Observed entry view model
    @ObservedObject var vm: EntryViewModel
    // Flag for email validation
    @State var isEmailValid: Bool = true

    private func emailOnSubmit() {
        guard vm.isEmailValid() else {
            isEmailValid = false
            return
        }
        TestViewModel().fetch(email: vm.email)
        isEmailValid = true
        vm.transition = .forward
        vm.switchView = .account
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
                    Text("Find Your\nPerfect match")
                        .fontTemplate(.bigBoldTitle)
                        .foregroundColor(Color.text)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .frame(height: 100)
                    
                    VStack(
                        alignment: .leading,
                        spacing: 10
                    ) {
                        PrimaryInputBar(
                            input: .email,
                            value: $vm.email,
                            hint: "Log in or sign up with email",
                            action: emailOnSubmit
                        )
                        .onSubmit {
                            emailOnSubmit()
                        }
                        
                        !isEmailValid
                        ? InputHelper(
                            isSatisfied: .constant(false),
                            label: "Please enter a valid email address",
                            type: .error
                        )
                        : nil
                    }
                    
                    HStack(spacing: 10) {
                        VStack {
                            Divider()
                        }
                        
                        Text("Continue with")
                            .fontTemplate(.pMedium)
                            .foregroundColor(Color.text)
                        
                        VStack {
                            Divider()
                        }
                    }
                    
                    HStack(
                        alignment: .center,
                        spacing: 20
                    ) {
                        SSOButton(
                            platform: .facebook,
                            handler: FacebookSSOViewModel().showFacebookLoginView
                        )
                        SSOButton(
                            platform: .google,
                            handler: GoogleSSOViewModel().showGoogleLoginView
                        )
                        SSOButton(
                            platform: .apple,
                            handler: AppleSSOViewModel().showAppleLoginView
                        )
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(vm: EntryViewModel())
    }
}
