//
//  EmailView.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//  Modified by Sam on 5/5/23.
//

import SwiftUI
import AuthenticationServices
import GraphQLAPI

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
        isLoading.toggle()
        self.endTextEditing()
        guard vm.isEmailValid(str: vm.user.email) else {
            isLoading.toggle()
            isEmailValid = false
            return
        }
        isEmailValid = true
        Task {
            do {
                let exist = try await EntryRepository.checkEmail(
                    email: vm.user.email
                )
                vm.user.socialAccount.append(
                    SocialAccount(
                        email: vm.user.email,
                        platform: .FINGERCROSSED
                    )
                )
                isLoading.toggle()
                vm.transition = .forward
                vm.switchView = exist ? .password : .account
            } catch {
                print(error.localizedDescription)
                isLoading.toggle()
                bm.pop(
                    title: "Something went wrong.",
                    type: .error
                )
            }
        }
    }
    /// Handler for google sso
    private func googleOnTap() {
        self.endTextEditing()
        GoogleSSOManager().signIn(
            successAction: { email in
                guard let email else {
                    bm.pop(
                        title: "Something went wrong.",
                        type: .error
                    )
                    return
                }
                Task {
                    do {
                        let exist = try await EntryRepository.checkEmail(
                            email: vm.user.email
                        )
                        if exist {
                            let (user, token) = try await EntryRepository.socialSignIn(
                                email: email,
                                platform: GraphQLEnum.case(.google)
                            )
                            userState.user = user
                            userState.token = token
                            userState.isLogin = true
                            userState.viewState = .main
                        }
                        vm.user.email = email
                        vm.user.googleConnect = true
                        vm.user.socialAccount.append(
                            SocialAccount(
                                email: email,
                                platform: .GOOGLE
                            )
                        )
                        vm.transition = .forward
                        vm.switchView = .name
                    } catch {
                        print(error.localizedDescription)
                        bm.pop(
                            title: "Something went wrong.",
                            type: .error
                        )
                    }
                }
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
                    bm.pop(
                        title: "Something went wrong.",
                        type: .error
                    )
                    return
                }
                let exist = try await EntryRepository.checkEmail(
                    email: email
                )
                if exist {
                    let (user, token) = try await EntryRepository.socialSignIn(
                        email: email,
                        platform: GraphQLEnum.case(.apple)
                    )
                    userState.user = user
                    userState.token = token
                    userState.isLogin = true
                    userState.viewState = .main
                }
                vm.user.email = email
                vm.user.appleConnect = true
                vm.user.socialAccount.append(
                    SocialAccount(
                        email: email,
                        platform: .APPLE
                    )
                )
                vm.transition = .forward
                vm.switchView = .name
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
                                value: $vm.user.email,
                                hint: "Log in or sign up with email",
                                isValid: $isEmailValid
                            )
                            .onChange(of: vm.user.email) { val in
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
