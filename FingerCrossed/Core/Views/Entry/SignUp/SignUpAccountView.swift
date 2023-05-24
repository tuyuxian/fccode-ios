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
    /// Flag for button tappable
    @State private var isStatisfied: Bool = false
    /// Flags for input helpers
    @State private var isLengthStatisfied: Bool = false
    @State private var isUpperAndLowerStatisfied: Bool = false
    @State private var isNumberAndSymbolStatisfied: Bool = false
    @State private var isPasswordMatched: Bool = false
    /// Flag for keyboard signal
    @State private var isKeyboardShowUp: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Flag for sheet
    @State private var isTermsPresented: Bool = false
    @State private var isPrivacyPresented: Bool = false
    
    private func buttonOnTap() {
        guard vm.isPasswordValid() else {
            isPasswordValid = false
            return
        }
        isPasswordValid = true
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
                        value: $vm.email,
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
                            isPasswordMatched
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
                        isPasswordMatched =
                            !vm.password.isEmpty &&
                            !password.isEmpty &&
                            vm.password == password
                        isStatisfied =
                            isLengthStatisfied &&
                            isUpperAndLowerStatisfied &&
                            isNumberAndSymbolStatisfied &&
                            isPasswordMatched
                    }
                    .onReceive(keyboardPublisher) { val in
                        isKeyboardShowUp = val
                    }

                    VStack(
                        alignment: .leading,
                        spacing: 6.0
                    ) {
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
                            isSatisfied: $isPasswordMatched,
                            label: "Passwords are matched",
                            type: .info
                        )
                    }
                    .padding(.top, -10)
                    .padding(.leading, 16)
                }
                
                Spacer()
                
                HStack(
                    alignment: .top,
                    spacing: 0.0
                ) {
                    Text("By continuing, I agree to Fingercrossed's ")
                        .foregroundColor(Color.surface1)
                        .fontTemplate(.noteMedium)
                    
                    TermsText(isTermsPresented: false)
                }
                
                HStack(
                    alignment: .top,
                    spacing: 0.0
                ) {
                    Text("and acknowledge the ")
                        .foregroundColor(Color.surface1)
                        .fontTemplate(.noteMedium)
                    
                    PrivacyText(isPrivacyPresented: false)
                }
                Spacer()
                    .ignoresSafeArea(.keyboard)
                    .frame(height: 30)
                
                PrimaryButton(
                    label: "Continue",
                    action: buttonOnTap,
                    isTappable: $isStatisfied,
                    isLoading: $isLoading
                )
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
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

private struct TermsText: View {
    @State var isTermsPresented: Bool = false
    
    var body: some View {
        VStack {
            Text("Terms of Service")
                .foregroundColor(Color.surface1)
                .fontTemplate(.noteMedium)
                .underline()
                .onTapGesture {
                    isTermsPresented.toggle()
                }
                .sheet(isPresented: $isTermsPresented) {
                    TermsOfServiceSheet(isPresented: $isTermsPresented)
                }
        }
        
    }
}

private struct PrivacyText: View {
    @State var isPrivacyPresented: Bool
    
    var body: some View {
        VStack {
            Text("Privacy Policy")
                .foregroundColor(Color.surface1)
                .fontTemplate(.noteMedium)
                .underline()
                .onTapGesture {
                    isPrivacyPresented.toggle()
                }
                .sheet(isPresented: $isPrivacyPresented) {
                    PrivacySheet(isPresented: $isPrivacyPresented)
                }
        }
        
    }
}
