//
//  SettingsResetPasswordViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/7/23.
//

import Foundation
import SwiftUI

class ResetPasswordViewModel: ObservableObject, InputProtocol {
    
    /// User state
    @AppStorage("UserId") private var userId: String = ""
    
    /// View state
    @Published var state: ViewStatus = .none
    @Published var currentPassword: String = ""
    @Published var newPassword: String = ""
    @Published var newPasswordConfirmed: String = ""
    
    /// Input bar conditions
    @Published var isCurrentPasswordMatched: Bool = true
    @Published var isNewPasswordValid: Bool = true
    @Published var isNewPasswordSatisfied: Bool = false
    @Published var isNewPasswordLengthSatisfied: Bool = false
    @Published var isNewPasswordUpperAndLowerSatisfied: Bool = false
    @Published var isNewPasswordNumberAndSymbolSatisfied: Bool = false
    @Published var isNewPasswordMatched: Bool = false
    
    /// Toast message
    @Published var toastMessage: String?
    @Published var toastType: Banner.BannerType?
    
}

extension ResetPasswordViewModel {
    
    @MainActor
    public func save() async {
        do {
            self.state = .loading
            guard
                self.isPasswordValid(str: self.newPassword) &&
                self.newPassword == self.newPasswordConfirmed
            else {
                self.isNewPasswordValid = false
                self.state = .none
                return
            }
            let statusCode = try await UserService.updatePassword(
                userId: self.userId,
                oldPassword: self.currentPassword != "" ? .some(self.currentPassword) : nil,
                newPassword: self.newPassword
            )
            guard statusCode == 200 else {
                self.state = .none
                self.isCurrentPasswordMatched = false
                return
            }
            self.state = .complete
        } catch {
            self.state = .error
            self.toastMessage = "Something went wrong"
            self.toastType = .error
            print(error.localizedDescription)
        }
    }
}
