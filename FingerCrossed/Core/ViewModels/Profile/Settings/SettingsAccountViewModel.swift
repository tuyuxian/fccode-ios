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
    let appleConnect: Bool
    let facebookConenct: Bool = false
    let googleConnect: Bool
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
        print("-> [Settings Account] vm init")
        self.appleConnect = appleConnect
        self.googleConnect = googleConnect
    }
    
    deinit {
        print("-> [Settings Account] vm deinit")
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
                        let statusCode = try await GraphAPI.deleteAccount(userId: self.userId)
                        guard statusCode == 200 else {
                            self.showErrorBanner()
                            return
                        }
                        self.state = .complete
                        action()
                        return
                    } catch {
                        self.showErrorBanner()
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
                self.showErrorBanner()
                return
            }
            let statusCode = try await GraphAPI.connectSocialAccount(
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
            self.state = .complete
        } catch {
            self.state = .none
            print(error.localizedDescription)
        }
    }
    
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
    
    private func showErrorBanner() {
        self.state = .error
        self.toastMessage = "Something went wrong"
        self.toastType = .error
    }
}
