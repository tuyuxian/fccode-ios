//
//  AccountExistSheet.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/1/23.
//

import SwiftUI
import GraphQLAPI

struct AccountExistSheet: View {
    @Environment(\.presentationMode) private var presentationMode
    /// Global banner
    @EnvironmentObject var bm: BannerManager
    /// Observed user state view model
    @ObservedObject var userState: UserStateViewModel
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    
    @State private var isSatisfied: Bool = false
    
    @State private var isLoading: Bool = false
    
    @State private var isSSO: Bool = false
    
    private func buttonOnTap() {
        // TODO(Sam): update to server before view dismiss
        presentationMode.wrappedValue.dismiss()
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
                horizontal: .leading,
                vertical: .top
            )
        ) {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                ZStack {
                    Text("Account Exists")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 34)
                        .multilineTextAlignment(.center)
                    
                    Button {
                        //
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Close")
                            .fontTemplate(.pMedium)
                            .foregroundColor(Color.gold)
                    }
                    .frame(height: 34)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.top, 30)
                
                Text("Looks like you already have an account\nPlease log in instead")
                    .fontTemplate(.noteMedium)
                    .foregroundColor(Color.text)
                    .frame(height: 32)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 18)
                
                VStack(
                spacing: 20
                ) {
                    Image("LandingBG")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                    
                    Text("Testing123@gamil.com")
                        .accentColor(Color.text)
                        .fontTemplate(.pMedium)
                    
                    if isSSO {
                        HStack(spacing: 10) {
                            LazyVStack {
                                Divider()
                            }
                            
                            Text("Continue with")
                                .fontTemplate(.pMedium)
                                .foregroundColor(Color.text)
                            
                            LazyVStack {
                                Divider()
                            }
                        }
                        
                        HStack(
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
                        .padding(.bottom, 10)
                    } else {
                        PrimaryInputBar(
                            input: .password,
                            value: .constant("Value"),
                            isValid: .constant(true)
                        )
                        
                        PrimaryButton(
                            label: "Continue",
                            isTappable: $isSatisfied,
                            isLoading: $isLoading
                        )
                        .padding(.bottom, 10)
                    }
                }
            }
            .padding(.horizontal, 24)
            .background(Color.white)
            .presentationDetents([.fraction(0.55)])
            .presentationDragIndicator(.visible)
            .scrollDismissesKeyboard(.automatic)
        }
    }
}

struct AccountExistSheet_Previews: PreviewProvider {
    static var previews: some View {
        AccountExistSheet(
            userState: UserStateViewModel(),
            vm: EntryViewModel()
        )
    }
}
