//
//  SettingsAccountViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/7/23.
//

import Foundation
import GraphQLAPI
import SwiftUI

class SettingsAccountViewModel: ObservableObject {
    
    let appleConnect: Bool
    let facebookConenct: Bool = false
    let googleConnect: Bool
    
    /// User State
    @AppStorage("UserId") private var userId: String = ""
    @AppStorage("Token") private var token: String = ""
    @AppStorage("IsLogin") private var isLogin: Bool = false
    private var appViewState: UserStateManager.ViewState = .onboarding
    
    @Published var state: ViewStatus = .none
    @Published var appAlert: AppAlert?
    @Published var errorMessage: String?
    
    init(
        appleConnect: Bool,
        googleConnect: Bool
    ) {
        self.appleConnect = appleConnect
        self.googleConnect = googleConnect
    }
    
    deinit {
        print("-> settings account view model deinit")
    }
}

extension SettingsAccountViewModel {
    public func signOutOnTap() {
        self.appAlert = .basic(
            title: "Are you sure you want to sign out?",
            message: "",
            actionLabel: "Yes",
            cancelLabel: "No",
            action: {
                DispatchQueue.main.async {
                    self.token = ""
                    self.userId = ""
                    self.isLogin = false
                    self.appViewState = .onboarding
                    UserDefaults.standard.removeObject(forKey: "UserMatchPreference")
                }
            }
        )
    }
    
    public func deleteAccountOnTap() {
        self.appAlert = .basic(
            title: "Do you really want to delete account?",
            // swiftlint: disable line_length
            message: "Please noted that once you delete your account, you will need to sign up again for our service.",
            // swiftlint: enable line_length
            actionLabel: "Yes",
            cancelLabel: "No",
            action: {
                Task {
                    DispatchQueue.main.async {
                        self.state = .loading
                    }
                    do {
                        let statusCode = try await GraphAPI.deleteAccount(
                            userId: self.userId
                        )
                        guard statusCode == 200 else {
                            self.showErrorBanner()
                            return
                        }
                        DispatchQueue.main.async {
                            self.state = .complete
                            self.token = ""
                            self.userId = ""
                            self.isLogin = false
                            self.appViewState = .onboarding
                            UserDefaults.standard.removeObject(forKey: "UserMatchPreference")
                        }
                        return
                    } catch {
                        self.showErrorBanner()
                        print(error.localizedDescription)
                    }
                }
            }
        )
    }
    
    public func connectApple() async {
        DispatchQueue.main.async {
            self.state = .loading
        }
        do {
            let email = try await AppleSSOManager().signIn()
            guard let email else {
                self.showErrorBanner()
                return
            }
            let statusCode = try await GraphAPI.connectSocialAccount(
                userId: self.userId,
                input: GraphQLAPI.CreateSocialAccountInput(
                    email: email,
                    platform: .case(.apple)
                )
            )
            guard statusCode == 200 else {
                self.showInfoAlert()
                return
            }
            DispatchQueue.main.async {
                self.state = .complete
            }
        } catch {
            DispatchQueue.main.async {
                self.state = .none
            }
            print(error.localizedDescription)
        }
    }
    
    public func connectFacebook() {}
    
    public func connectGoogle() async {
        DispatchQueue.main.async {
            self.state = .loading
            GoogleSSOManager().signIn(
                successAction: { email in
                    guard let email else {
                        self.showErrorBanner()
                        return
                    }
                    Task {
                        do {
                            let statusCode = try await GraphAPI.connectSocialAccount(
                                userId: self.userId,
                                input: GraphQLAPI.CreateSocialAccountInput(
                                    email: email,
                                    platform: .case(.google)
                                )
                            )
                            print(statusCode)
                            guard statusCode == 200 else {
                                self.showInfoAlert()
                                return
                            }
                            DispatchQueue.main.async {
                                self.state = .complete
                            }
                        } catch {
                            self.showErrorBanner()
                            print(error.localizedDescription)
                        }
                    }
                },
                errorAction: { error in
                    guard let error else { return }
                    DispatchQueue.main.async {
                        self.state = .none
                    }
                    print(error.localizedDescription)
                }
            )
        }
    }
    
    private func showInfoAlert() {
        DispatchQueue.main.async {
            self.state = .none
            self.appAlert = .basic(
                title: "Oopsie!",
                message: "The email is connected to another user.",
                actionLabel: "",
                cancelLabel: "Cancel",
                action: {}
            )
        }
    }
    
    private func showErrorBanner() {
        DispatchQueue.main.async {
            self.state = .error
            self.errorMessage = "Something went wrong"
        }
    }
}
