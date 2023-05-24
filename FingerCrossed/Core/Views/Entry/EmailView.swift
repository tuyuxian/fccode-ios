//
//  EmailView.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//  Modified by Sam on 5/5/23.
//

import SwiftUI
import AuthenticationServices

struct EmailView: View {
    /// Global banner
    @EnvironmentObject var bm: BannerManager
    /// Observed user state view model
    @ObservedObject var userState: UserStateViewModel
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Flag for email validation
    @State private var isEmailValid: Bool = true
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Handler for button on submit
    private func buttonOnTap() {
        self.endTextEditing()
        guard vm.isEmailValid(str: vm.email) else {
            isEmailValid = false
            return
        }
        isEmailValid = true
        vm.transition = .forward
        vm.switchView = .password
    }
    /// Handler for facebook sso
    private func facebookOnTap() {
        self.endTextEditing()
        FacebookSSOManager().signIn(
            successAction: { email in
                vm.email = email ?? ""
            },
            errorAction: { error in
                guard let error else { return }
                print(error.localizedDescription)
            }
        )
    }
    /// Handler for google sso
    private func googleOnTap() {
        self.endTextEditing()
        GoogleSSOManager().signIn(
            successAction: { email in
                guard let email else {
                    bm.banner = .init(
                        title: "Something went wrong.",
                        type: .error
                    )
                    return
                }
                vm.email = email
                userState.isLogin = true
                userState.viewState = .main
            },
            errorAction: { error in
                guard let error else { return }
                print(error.localizedDescription)
            }
        )
    }
    /// Handler for apple sso
    private func appleOnTap() async {
        self.endTextEditing()
        Task {
            do {
                let email = try await AppleSSOManager().signIn()
                guard let email else {
                    bm.banner = .init(
                        title: "Something went wrong.",
                        type: .error
                    )
                    return
                }
                vm.email = email
            } catch {
                print(error.localizedDescription)
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
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    EntryLogo()
                        .padding(.top, 5)
                        .padding(.bottom, 55)
                    
                    LazyVStack(spacing: 30) {
                        Text("Find Your\nPerfect match")
                            .fontTemplate(.bigBoldTitle)
                            .foregroundColor(Color.text)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            .frame(height: 100)
                        
                        LazyVStack(
                            alignment: .leading,
                            spacing: 30
                        ) {
                            PrimaryInputBar(
                                input: .email,
                                value: $vm.email,
                                hint: "Log in or sign up with email",
                                isValid: $isEmailValid
                            )
                            .onChange(of: vm.email) { val in
                                vm.isEmailSatisfied = val.count > 0
                            }
                            
                            !isEmailValid
                            ? InputHelper(
                                isSatisfied: .constant(false),
                                label: "Please enter a valid email address",
                                type: .error
                            )
                            .padding(.leading, 16)
                            .padding(.vertical, -20)
                            : nil
                            
                            PrimaryButton(
                                label: "Continue",
                                action: buttonOnTap,
                                isTappable: $vm.isEmailSatisfied,
                                isLoading: $isLoading
                            )
                        }
                        
                        HStack(spacing: 10) {
                            LazyVStack {
                                Divider()
                            }
                            
                            Text("Or")
                                .fontTemplate(.pMedium)
                                .foregroundColor(Color.text)
                            
                            LazyVStack {
                                Divider()
                            }
                        }
                        
                        LazyHStack(
                            alignment: .center,
                            spacing: 20
                        ) {
                            SSOButton(
                                platform: .facebook,
                                handler: {
                                    facebookOnTap()
                                }
                            )
                            SSOButton(
                                platform: .google,
                                handler: {
                                    googleOnTap()
                                }
                            )
                            SSOButton(
                                platform: .apple,
                                handler: {
                                    Task {
                                        await appleOnTap()
                                    }
                                }
                            )
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

struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView(
            userState: UserStateViewModel(),
            vm: EntryViewModel()
        )
    }
}
