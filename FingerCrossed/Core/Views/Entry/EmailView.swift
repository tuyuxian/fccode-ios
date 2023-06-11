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
    /// Global page spinner
    @EnvironmentObject var psm: PageSpinnerManager
    /// Observed user state view model
    @ObservedObject var usm: UserStateManager
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Init account sheet view model
    @StateObject var accountSheetVM: AccountSheetViewModel = AccountSheetViewModel()
    /// Flag for email validation
    @State private var isEmailValid: Bool = true
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Flag for account sheet
    @State private var isAccountPresented: Bool = false
    /// Flag for term sheet
    @State private var isTermsPresented: Bool = false
    /// Flag for privacy sheet
    @State private var isPrivacyPresented: Bool = false
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
                let (
                    userExist,
                    hasPassword,
                    hasAppleSSO,
                    _,
                    hasGoogleSSO,
                    username,
                    profilePictureUrl,
                    appleEmail,
                    facebookEmail,
                    googleEmail
                ) = try await GraphAPI.checkEmail(
                    email: vm.user.email
                )
                guard userExist else {
                    vm.user.socialAccount.append(
                        SocialAccount(
                            email: vm.user.email,
                            platform: .fingercrossed
                        )
                    )
                    isLoading.toggle()
                    vm.transition = .forward
                    vm.switchView = .account
                    return
                }
                guard hasPassword ?? true else {
                    accountSheetVM.isSSO = true
                    accountSheetVM.showAppleSSO = hasAppleSSO ?? false
                    accountSheetVM.showGoogleSSO = hasGoogleSSO ?? false
                    accountSheetVM.email = vm.user.email
                    accountSheetVM.appleEmail = appleEmail
                    accountSheetVM.facebookEmail = facebookEmail
                    accountSheetVM.googleEmail = googleEmail
                    accountSheetVM.username = username
                    accountSheetVM.profilePictureUrl = profilePictureUrl
                    isAccountPresented.toggle()
                    isLoading.toggle()
                    return
                }
                isLoading.toggle()
                vm.transition = .forward
                vm.switchView = .password
            } catch {
                isLoading.toggle()
                print(error.localizedDescription)
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
        psm.show()
        Task {
            do {
                let email = try await GoogleSSOManager().signIn()
                psm.dismiss()
                guard let email else {
                    bm.pop(
                        title: "Something went wrong.",
                        type: .error
                    )
                    return
                }
                let (
                    userExist,
                    hasPassword,
                    hasAppleSSO,
                    _,
                    hasGoogleSSO,
                    username,
                    profilePictureUrl,
                    appleEmail,
                    facebookEmail,
                    googleEmail
                ) = try await GraphAPI.checkEmail(
                    email: email
                )
                guard userExist else {
                    vm.user.socialAccount.append(
                        SocialAccount(
                            email: email,
                            platform: .google
                        )
                    )
                    vm.user.email = email
                    vm.user.googleConnect = true
                    vm.transition = .forward
                    vm.switchView = .name
                    return
                }
                guard hasGoogleSSO ?? false else {
                    guard hasPassword ?? true else {
                        accountSheetVM.isSSO = true
                        accountSheetVM.showAppleSSO = hasAppleSSO ?? false
                        accountSheetVM.email = email
                        accountSheetVM.appleEmail = appleEmail
                        accountSheetVM.facebookEmail = facebookEmail
                        accountSheetVM.googleEmail = googleEmail
                        accountSheetVM.username = username
                        accountSheetVM.profilePictureUrl = profilePictureUrl
                        isAccountPresented.toggle()
                        return
                    }
                    accountSheetVM.isSSO = false
                    accountSheetVM.email = email
                    accountSheetVM.username = username
                    accountSheetVM.profilePictureUrl = profilePictureUrl
                    isAccountPresented.toggle()
                    return
                }
                let (userId, token) = try await GraphAPI.socialSignIn(
                    email: email,
                    platform: GraphQLEnum.case(.google)
                )
                usm.userId = userId
                usm.token = token
                usm.isLogin = true
                usm.viewState = .main
            } catch {
                psm.dismiss()
                print(error.localizedDescription)
            }
        }
    }
    /// Handler for apple sso
    private func appleOnTap() {
        self.endTextEditing()
        psm.show()
        Task {
            do {
                let email = try await AppleSSOManager().signIn()
                psm.dismiss()
                guard let email else {
                    bm.pop(
                        title: "Something went wrong.",
                        type: .error
                    )
                    return
                }
                let (
                    userExist,
                    hasPassword,
                    hasAppleSSO,
                    _,
                    hasGoogleSSO,
                    username,
                    profilePictureUrl,
                    appleEmail,
                    facebookEmail,
                    googleEmail
                ) = try await GraphAPI.checkEmail(
                    email: email
                )
                guard userExist else {
                    vm.user.socialAccount.append(
                        SocialAccount(
                            email: email,
                            platform: .apple
                        )
                    )
                    vm.user.email = email
                    vm.user.appleConnect = true
                    vm.transition = .forward
                    vm.switchView = .name
                    return
                }
                guard hasAppleSSO ?? false else {
                    guard hasPassword ?? true else {
                        accountSheetVM.isSSO = true
                        accountSheetVM.showGoogleSSO = hasGoogleSSO ?? false
                        accountSheetVM.email = email
                        accountSheetVM.appleEmail = appleEmail
                        accountSheetVM.facebookEmail = facebookEmail
                        accountSheetVM.googleEmail = googleEmail
                        accountSheetVM.username = username
                        accountSheetVM.profilePictureUrl = profilePictureUrl
                        isAccountPresented.toggle()
                        return
                    }
                    accountSheetVM.isSSO = false
                    accountSheetVM.email = email
                    accountSheetVM.username = username
                    accountSheetVM.profilePictureUrl = profilePictureUrl
                    isAccountPresented.toggle()
                    return
                }
                let (userId, token) = try await GraphAPI.socialSignIn(
                    email: email,
                    platform: GraphQLEnum.case(.apple)
                )
                usm.userId = userId
                usm.token = token
                usm.isLogin = true
                usm.viewState = .main
            } catch {
                psm.dismiss()
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
                            .padding(.top, -20)
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
                                    appleOnTap()
                                }
                            )
                        }
                        
                        VStack(
                            alignment: .center,
                            spacing: 0
                        ) {
                            HStack(
                                alignment: .top,
                                spacing: 0
                            ) {
                                Text("By continuing, I agree to Fingercrossed's ")
                                    .foregroundColor(Color.surface1)
                                    .fontTemplate(.noteMedium)
                                
                                Text("Terms of Service")
                                    .foregroundColor(Color.surface1)
                                    .fontTemplate(.noteMedium)
                                    .underline()
                                    .onTapGesture {
                                        isTermsPresented.toggle()
                                    }
                                    .sheet(isPresented: $isTermsPresented) {
                                        TermsOfServiceSheet()
                                    }
                            }
                            
                            HStack(
                                alignment: .top,
                                spacing: 0
                            ) {
                                Text("and acknowledge the ")
                                    .foregroundColor(Color.surface1)
                                    .fontTemplate(.noteMedium)
                                
                                Text("Privacy Policy")
                                    .foregroundColor(Color.surface1)
                                    .fontTemplate(.noteMedium)
                                    .underline()
                                    .onTapGesture {
                                        isPrivacyPresented.toggle()
                                    }
                                    .sheet(isPresented: $isPrivacyPresented) {
                                        PrivacySheet()
                                    }
                                
                                Text(".")
                                    .foregroundColor(Color.surface1)
                                    .fontTemplate(.noteMedium)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
            .scrollDisabled(true)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.16)) {
                    UIApplication.shared.closeKeyboard()
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .sheet(isPresented: $isAccountPresented) {
                AccountSheet(
                    usm: usm,
                    entry: vm,
                    vm: accountSheetVM
                )
            }
        }
    }
}

struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView(
            usm: UserStateManager(),
            vm: EntryViewModel()
        )
    }
}
