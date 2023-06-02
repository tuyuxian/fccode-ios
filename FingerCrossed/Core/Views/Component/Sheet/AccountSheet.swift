//
//  AccountSheet.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/1/23.
//

import SwiftUI
import GraphQLAPI

struct AccountSheet: View {
    @Environment(\.presentationMode) private var presentationMode
    /// Global banner
    @EnvironmentObject var bm: BannerManager
    /// Global page spinner
    @EnvironmentObject var psm: PageSpinnerManager
    /// Observed user state view model
    @ObservedObject var userState: UserStateViewModel
    /// Observed entry view model
    @ObservedObject var entry: EntryViewModel
    /// Observed account sheet view model
    @ObservedObject var vm: AccountSheetViewModel
    /// Flag for password validation
    @State private var isPasswordValid: Bool = true
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Handler for button on tap
    private func buttonOnTap() {
        isLoading.toggle()
        self.endTextEditing()
        guard entry.isPasswordValid(str: vm.password) else {
            isPasswordValid = false
            isLoading.toggle()
            return
        }
        isPasswordValid = true
        Task {
            do {
                let (user, token) = try await EntryRepository.signIn(
                    email: vm.email,
                    password: vm.password
                )
                isLoading.toggle()
                userState.user = user
                userState.token = token
                userState.isLogin = true
                userState.viewState = .main
            } catch {
                if error.localizedDescription == "Wrong password" {
                    isPasswordValid = false
                    return
                }
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
        psm.show()
        GoogleSSOManager().signIn(
            successAction: { email in
                guard let email else {
                    bm.pop(
                        title: "Something went wrong.",
                        type: .error
                    )
                    return
                }
                psm.dismiss()
                guard email == vm.googleEmail else {
                    // handle invalid login
                    return
                }
                Task {
                    do {
                        let (user, token) = try await EntryRepository.socialSignIn(
                            email: email,
                            platform: GraphQLEnum.case(.google)
                        )
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
            },
            errorAction: { error in
                psm.dismiss()
                guard let error else { return }
                print(error.localizedDescription)
            }
        )
    }
    /// Handler for apple sso
    private func appleOnTap() {
        psm.show()
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
                psm.dismiss()
                guard email == vm.appleEmail else {
                    // handle invalid login
                    return
                }
                let (user, token) = try await EntryRepository.socialSignIn(
                    email: email,
                    platform: GraphQLEnum.case(.apple)
                )
                userState.user = user
                userState.token = token
                userState.isLogin = true
                userState.viewState = .main
            } catch {
                psm.dismiss()
                print(error.localizedDescription)
            }
        }
    }
    
    init(
        userState: UserStateViewModel,
        entry: EntryViewModel,
        vm: AccountSheetViewModel
    ) {
        self.userState = userState
        self.entry = entry
        self.vm = vm
    }
    
    var body: some View {
        Sheet(
            size: [.fraction(0.6)],
            showDragIndicator: false,
            hasHeader: false,
            content: {
                VStack(spacing: 0) {
                    ZStack {
                        Text("Account Exists")
                            .fontTemplate(.h2Medium)
                            .foregroundColor(Color.text)
                            .frame(height: 34)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Close")
                                .fontTemplate(.pMedium)
                                .foregroundColor(Color.gold)
                        }
                        .frame(height: 34)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .trailing
                        )
                    }
                    .padding(.top, 30)
                    
                    Text("Looks like you already have an account.\nPlease log in instead.")
                        .fontTemplate(.noteMedium)
                        .foregroundColor(Color.text)
                        .frame(height: 32)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)
                        .padding(.bottom, 38)
                    
                    VStack(spacing: 20) {
                        Avatar(
                            avatarUrl: vm.profilePictureUrl,
                            size: 120,
                            isActive: false
                        )
                        
                        Text(vm.email)
                            .accentColor(Color.text)
                            .fontTemplate(.pMedium)
                        
                        if vm.isSSO {
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
                                vm.showGoogleSSO
                                ? SSOButton(
                                    platform: .google,
                                    handler: {
                                        googleOnTap()
                                    }
                                )
                                : nil
                                
                                vm.showAppleSSO
                                ? SSOButton(
                                    platform: .apple,
                                    handler: {
                                        appleOnTap()
                                    }
                                )
                                : nil
                            }
                        } else {
                            PrimaryInputBar(
                                input: .password,
                                value: $vm.password,
                                hint: "Password",
                                isValid: $isPasswordValid
                            )
                            .onChange(of: vm.password) { val in
                                vm.isPasswordSatisfied = val.count > 0
                            }
                            
//                            !isPasswordValid
//                            ? ErrorHelper(action: forgotPasswordOnTap)
//                                .padding(.leading, 16)
//                                .padding(.vertical, -20)
//                            : nil
                            
                            PrimaryButton(
                                label: "Continue",
                                action: buttonOnTap,
                                isTappable: $vm.isPasswordSatisfied,
                                isLoading: $isLoading
                            )
                        }
                    }
                    .padding(.bottom, 16)
                }
            },
            footer: {}
        )
    }
}

struct AccountSheet_Previews: PreviewProvider {
    static var previews: some View {
        AccountSheet(
            userState: UserStateViewModel(),
            entry: EntryViewModel(),
            vm: AccountSheetViewModel()
        )
    }
}
