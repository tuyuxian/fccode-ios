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
    
    /// User state
    @AppStorage("UserId") private var userId: String = ""

    /// View state
    @Published var appleConnect: Bool
    @Published var facebookConnect: Bool = false
    @Published var googleConnect: Bool
    @Published var state: ViewStatus = .none
    
    /// Alert
    @Published var appAlert: AppAlert?
    
    /// Toast message
    @Published var toastMessage: String?
    @Published var toastType: Banner.BannerType?
    
    init(
        appleConnect: Bool,
        googleConnect: Bool
    ) {
        self.appleConnect = appleConnect
        self.googleConnect = googleConnect
    }
    
}

extension SettingsAccountViewModel {
    enum SettingsAccountError: Error {
        case unknown
        case deleteUserFailed
        case signOutUserFailed
        case appleSSOGetEmailFailed
        case googleSSOGetEmailFailed
    }
}

extension SettingsAccountViewModel {
    
    @MainActor
    public func signOutOnTap(
        action: @escaping () -> Void
    ) {
        self.appAlert = .basic(
            title: "Are you sure you want to sign out?",
            message: "",
            actionLabel: "Yes",
            cancelLabel: "No",
            action: action
        )
    }
    
    @MainActor
    public func deleteAccountOnTap(
        action: @escaping () -> Void
    ) {
        self.appAlert = .basic(
            title: "Do you really want to delete account?",
            // swiftlint: disable line_length
            message: "Please noted that once you delete your account, you will need to sign up again for our service.",
            // swiftlint: enable line_length
            actionLabel: "Yes",
            cancelLabel: "No",
            action: {
                Task {
                    do {
                        self.state = .loading
                        let statusCode = try await UserService.deleteAccount(userId: self.userId)
                        guard statusCode == 200 else {
                            throw SettingsAccountError.deleteUserFailed
                        }
                        self.state = .complete
                        action()
                    } catch {
                        self.showError()
                        print(error.localizedDescription)
                    }
                }
            }
        )
    }
    
    @MainActor
    public func connectApple() async {
        do {
            self.state = .loading
            let email = try await AppleSSOManager().signIn()
            guard let email else {
                throw SettingsAccountError.appleSSOGetEmailFailed
            }
            let statusCode = try await UserService.connectSocialAccount(
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
            self.appleConnect = true
            self.state = .complete
        } catch {
            self.state = .none
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    public func connectFacebook() async {}
    
    @MainActor
    public func connectGoogle() async {
        do {
            self.state = .loading
            let email = try await GoogleSSOManager().signIn()
            guard let email else {
                throw SettingsAccountError.googleSSOGetEmailFailed
            }
            let statusCode = try await UserService.connectSocialAccount(
                userId: self.userId,
                input: GraphQLAPI.CreateSocialAccountInput(
                    email: email,
                    platform: .case(.google)
                )
            )
            guard statusCode == 200 else {
                self.showInfoAlert()
                return
            }
            self.googleConnect = true
            self.state = .complete
        } catch {
            self.state = .none
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    private func showInfoAlert() {
        self.state = .none
        self.appAlert = .basic(
            title: "Oopsie!",
            message: "The email is connected to another user.",
            actionLabel: "",
            cancelLabel: "Cancel",
            action: {}
        )
    }
    
    @MainActor
    public func showError() {
        self.state = .error
        self.toastMessage = "Something went wrong"
        self.toastType = .error
    }
}
