//
//  PasswordView.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//  Modified by Sam on 5/5/23.
//

import SwiftUI
import GraphQLAPI

struct PasswordView: View {
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
    /// Flag for account sheet
    @State private var isAccountPresented: Bool = false
    /// Flag for password validation
    @State private var isPasswordValid: Bool = true
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Handler for button on tap
    private func buttonOnTap() {
        isLoading.toggle()
        self.endTextEditing()
        guard vm.isPasswordValid(str: vm.password) else {
            isPasswordValid = false
            isLoading.toggle()
            return
        }
        isPasswordValid = true
        Task {
            do {
                let (statusCode, userId, token) = try await GraphAPI.signIn(
                    email: vm.user.email,
                    password: vm.password
                )
                isLoading.toggle()
                guard statusCode == 200 else {
                    isPasswordValid = false
                    return
                }
                usm.userId = userId
                usm.token = token
                usm.isLogin = true
                usm.viewState = .main
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
    /// Handler for forgot password
    private func forgotPasswordOnTap() {
        self.endTextEditing()
        vm.transition = .forward
        vm.switchView = .resetPasswordEmailCheck
    }
    /// Handler for back to email view
    private func backToEmailView() {
        self.endTextEditing()
        vm.transition = .backward
        vm.switchView = .email
        vm.user.email = ""
        vm.password = ""
        vm.isEmailSatisfied = false
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
                LazyVStack(
                    alignment: .center,
                    spacing: 0
                ) {
                    LazyHStack(
                        alignment: .center,
                        spacing: 0
                    ) {
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
                            spacing: 30
                        ) {
                            PrimaryInputBar(
                                input: .password,
                                value: $vm.password,
                                hint: "Password",
                                isValid: $isPasswordValid
                            )
                            .onChange(of: vm.password) { val in
                                vm.isPasswordSatisfied = val.count > 0
                            }
                            
                            !isPasswordValid
                            ? PasswordErrorHelper(action: forgotPasswordOnTap)
                                .padding(.leading, 16)
                                .padding(.top, -20)
                            : nil
                            
                            PrimaryButton(
                                label: "Continue",
                                action: buttonOnTap,
                                isTappable: $vm.isPasswordSatisfied,
                                isLoading: $isLoading
                            )
                            
                            LazyVStack(alignment: .center, spacing: 30) {
                                !isPasswordValid
                                ? nil
                                : Button {
                                    forgotPasswordOnTap()
                                } label: {
                                    Text("Forgot password")
                                        .fontTemplate(.noteMedium)
                                        .foregroundColor(Color.text)
                                        .underline(
                                            true,
                                            color: Color.text
                                        )
                                }
                                
                                Button {
                                    backToEmailView()
                                } label: {
                                    Text("Not to continue with \(vm.user.email)?")
                                        .fontTemplate(.noteMedium)
                                        .foregroundColor(Color.text)
                                        .underline(
                                            true,
                                            color: Color.text
                                        )
                                }
                            }
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

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView(
            usm: UserStateManager(),
            vm: EntryViewModel()
        )
    }
}

struct PasswordErrorHelper: View {
    
    @State var action: () -> Void
    
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
                    .frame(
                        width: 16,
                        height: 16
                    )
                VStack(alignment: .leading, spacing: 0) {
                    Text("Hmm, that's not the right password.")
                        .fontTemplate(.noteMedium)
                        .foregroundColor(Color.warning)
                    HStack(spacing: 0) {
                        Text("Please try again or tap ")
                            .fontTemplate(.noteMedium)
                            .foregroundColor(Color.warning)
                        Text("Forgot password")
                            .fontTemplate(.noteMedium)
                            .foregroundColor(Color.warning)
                            .underline(
                                true,
                                color: Color.warning
                            )
                            .onTapGesture {
                                self.endTextEditing()
                                action()
                            }
                        Text(".")
                            .fontTemplate(.noteMedium)
                            .foregroundColor(Color.warning)
                    }
                }
            }
        }
    }
}
