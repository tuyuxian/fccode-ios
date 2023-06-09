//
//  SettingsResetPasswordViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/7/23.
//

import Foundation
import SwiftUI

class ResetPasswordViewModel: ObservableObject, InputProtocol {
    
    let hasPassword: Bool

    @AppStorage("UserId") private var userId: String = ""
    
    // MARK: State Management
    @Published var state: ViewStatus = .none
    @Published var errorMessage: String?
    @Published var currentPassword: String = ""
    @Published var newPassword: String = ""
    @Published var newPasswordConfirmed: String = ""
    @Published var isNewPasswordValid: Bool = true
    
    // MARK: Condition Variables for button
    @Published var isNewPasswordSatisfied: Bool = false
    @Published var isCurrentPasswordMatched: Bool = true
    @Published var isNewPasswordLengthSatisfied: Bool = false
    @Published var isNewPasswordUpperAndLowerSatisfied: Bool = false
    @Published var isNewPasswordNumberAndSymbolSatisfied: Bool = false
    @Published var isNewPasswordMatched: Bool = false
    
    init(
        hasPassword: Bool
    ) {
        self.hasPassword = hasPassword
    }
    
    deinit {
        print("-> reset password view model deinit")
    }
}

extension ResetPasswordViewModel {
    public func buttonOnTap() async {
        DispatchQueue.main.async {
            self.state = .loading
        }
        guard self.isPasswordValid(str: self.newPassword) &&
                self.newPassword == self.newPasswordConfirmed
        else {
            DispatchQueue.main.async {
                self.isNewPasswordValid = false
                self.state = .none
            }
            return
        }
        do {
            let statusCode = try await GraphAPI.updatePassword(
                userId: self.userId,
                oldPassword: self.currentPassword != "" ? .some(self.currentPassword) : nil,
                newPassword: self.newPassword
            )
            guard statusCode == 200 else {
                DispatchQueue.main.async {
                    self.state = .none
                    self.isCurrentPasswordMatched = false
                }
                return
            }
            DispatchQueue.main.async {
                self.state = .complete
            }
        } catch {
            DispatchQueue.main.async {
                self.state = .error
                self.errorMessage = "Something went wrong"
            }
            print(error.localizedDescription)
        }
    }
}
