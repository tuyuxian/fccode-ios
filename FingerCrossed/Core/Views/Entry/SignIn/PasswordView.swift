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
    /// Observed user state view model
    @ObservedObject var userState: UserStateViewModel
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
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
                let (user, token) = try await EntryRepository.signIn(
                    email: vm.user.email,
                    password: vm.password
                )
                isLoading.toggle()
                userState.user = user
                userState.token = token
                userState.isLogin = true
                userState.viewState = .main
            } catch {
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
                LazyVStack(
                    alignment: .leading,
                    spacing: 0
                ) {
                    LazyHStack(
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
                            ? ErrorHelper(action: forgotPasswordOnTap)
                                .padding(.leading, 16)
                                .padding(.vertical, -20)
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

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView(
            userState: UserStateViewModel(),
            vm: EntryViewModel()
        )
    }
}

private struct ErrorHelper: View {
    
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
                Image("Error")
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
