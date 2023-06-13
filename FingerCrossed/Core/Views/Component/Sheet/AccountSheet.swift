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
    @ObservedObject var usm: UserStateManager
    /// Observed entry view model
    @ObservedObject var entry: EntryViewModel
    /// Observed account sheet view model
    @ObservedObject var vm: AccountSheetViewModel
    /// Flag for password validation
    @State private var isPasswordValid: Bool = true
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Flag for alert
    @State private var showAlert: Bool = false
    /// Handler for forgot password
    private func forgotPasswordOnTap() {
        self.endTextEditing()
        guard let email = vm.email else { return }
        entry.user.email = email
        presentationMode.wrappedValue.dismiss()
        entry.transition = .forward
        entry.switchView = .resetPasswordEmailCheck
    }
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
        guard let email = vm.email else {
            isLoading.toggle()
            return
        }
        Task {
            do {
                let (statusCode, userId, token) = try await UserService.signIn(
                    email: email,
                    password: vm.password
                )
                isLoading.toggle()
                guard statusCode == 200 else {
                    isPasswordValid = false
                    return
                }
                usm.userId = userId
                usm.token = token
                presentationMode.wrappedValue.dismiss()
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
    /// Handler for google sso
    private func googleOnTap() {
        psm.show()
        Task {
            do {
                let email = try await GoogleSSOManager().signIn()
                guard let email else {
                    bm.pop(
                        title: "Something went wrong.",
                        type: .error
                    )
                    return
                }
                psm.dismiss()
                guard email == vm.googleEmail else {
                    showAlert.toggle()
                    return
                }
                let (userId, token) = try await UserService.socialSignIn(
                    email: email,
                    platform: GraphQLEnum.case(.google)
                )
                usm.userId = userId
                usm.token = token
                usm.isLogin = true
                usm.viewState = .main
                presentationMode.wrappedValue.dismiss()
            } catch {
                psm.dismiss()
                print(error.localizedDescription)
            }
        }
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
                    showAlert.toggle()
                    return
                }
                let (userId, token) = try await UserService.socialSignIn(
                    email: email,
                    platform: GraphQLEnum.case(.apple)
                )
                usm.userId = userId
                usm.token = token
                usm.isLogin = true
                usm.viewState = .main
                presentationMode.wrappedValue.dismiss()
            } catch {
                psm.dismiss()
                print(error.localizedDescription)
            }
        }
    }
    
    init(
        usm: UserStateManager,
        entry: EntryViewModel,
        vm: AccountSheetViewModel
    ) {
        self.usm = usm
        self.entry = entry
        self.vm = vm
    }
    
    var body: some View {
        Sheet(
            size: [.height(420)],
            showDragIndicator: false,
            hasFooter: false,
            header: {
                ZStack {
                    Text("Account Exists")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 34)
                        .multilineTextAlignment(.center)
                    
                    Button {
                        vm.password = ""
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
                .padding(.top, 15) // 30 - 15
            },
            content: {
                VStack(spacing: 0) {
                    Text("Looks like you already have an account.\nPlease log in instead.")
                        .fontTemplate(.noteMedium)
                        .foregroundColor(Color.text)
                        .frame(height: 32)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)
                        .padding(.bottom, vm.isSSO ? 67 : isPasswordValid ? 51 : 30)
                    
                    VStack(
                        alignment: .leading,
                        spacing: 0
                    ) {
                        HStack(
                            alignment: .center,
                            spacing: 20
                        ) {
                            Avatar(
                                avatarUrl: vm.profilePictureUrl ?? "",
                                size: 80,
                                isActive: false
                            )
                            VStack(
                                alignment: .leading,
                                spacing: vm.username != nil ? 4 : 16
                            ) {
                                if vm.username != nil {
                                    Text(vm.username ?? "")
                                        .fontTemplate(.pMedium)
                                        .foregroundColor(Color.text)
                                } else {
                                    Shimmer(
                                        size: CGSize(
                                            width: 121,
                                            height: 24
                                        )
                                    )
                                }
                                
                                if vm.email != nil {
                                    Text(vm.email ?? "")
                                        .fontTemplate(.pMedium)
                                        .foregroundColor(Color.textHelper)
                                } else {
                                    Shimmer(
                                        size: CGSize(
                                            width: 242,
                                            height: 24
                                        )
                                    )
                                }
                            }
                        }
                        .padding(.bottom, vm.isSSO ? 67 : isPasswordValid ? 51 : 30)
                        
                        if vm.isSSO {
                            VStack(
                                alignment: .center,
                                spacing: 30
                            ) {
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
                            }
                        } else {
                            VStack(
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
                            }
                        }
                    }
                    .padding(.bottom, 16)
                }
                .interactiveDismissDisabled()
            },
            footer: {}
        )
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(
                    "Oopsie!"
                )
                .font(
                    Font.system(
                        size: 18,
                        weight: .medium
                    )
                ),
                message: Text(
                    "The account you chose didn’t match the initial email address provided."
                ),
                dismissButton: .default(
                    Text("Cancel")
                )
            )
        }
    }
}

struct AccountSheet_Previews: PreviewProvider {
    static var previews: some View {
        AccountSheet(
            usm: UserStateManager(),
            entry: EntryViewModel(),
            vm: AccountSheetViewModel()
        )
    }
}
