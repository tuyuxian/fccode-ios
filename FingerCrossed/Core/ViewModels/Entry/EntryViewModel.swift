//
//  EntryViewModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/25/23.
//

import Foundation
import SwiftUI

class EntryViewModel: ObservableObject, Equatable {
    static func == (lhs: EntryViewModel, rhs: EntryViewModel) -> Bool {
        return lhs.email == rhs.email
    }
    
    @Published var isNewUser: Bool = true
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmed = ""
    @Published var newPassword: String = ""
    @Published var newPasswordConfirmed = ""
    @Published var name: String = ""
    @Published var dateOfBirth: String = ""
    @Published var selectedDate: Date = Date()
    @Published var gender: Gender?
    @Published var nationality = [CountryModel]()
    @Published var ethnicity = [Ethnicity]()
    @Published var avatarUrl: String?
    @Published var isQualified: Bool = false
    @Published var yearIndex = 99
    @Published var monthIndex = Calendar.current.component(.month, from: Date()) - 1
    @Published var dayIndex = Calendar.current.component(.day, from: Date()) - 1
    
    enum CurrentView: Int {
        case onboarding
        case password
        case resetPassword
        case resetPasswordEmailCheck
        case account
        case name
        case birthday
        case gender
        case ethnicity
        case nationality
        case avatar
    }
    
    enum Transition: Int {
        case forward
        case backward
    }
    
    /// Default is forward transition
    @Published var transition: Transition = .forward
    
    // @AppStorage("entryState") var switchView = CurrentView.onboarding
    @Published var switchView = CurrentView.onboarding
    
    // MARK: - Validation functions
    public func isEmailValid() -> Bool {
        // swiftlint:disable line_length
        /// Email regex from MDN
        let emailRegex = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        // swiftlint:enable line_length
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    /// Password regex
    /// Rules
    /// - 8 - 36 characters
    /// - at least 1 uppercase
    /// - at least 1 lowercase
    /// - at least 1 number
    /// - at least 1 symbol (!&^%$#@()/_*+-)
    public func isPasswordValid() -> Bool {
        // swiftlint: disable line_length
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!&^%$#@()/_*+-])[A-Za-z\\d!&^%$#@()/_*+-]{8,36}$"
        // swiftlint: enable line_length
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    /// New Password regex
    /// Rules
    /// - 8 - 36 characters
    /// - at least 1 uppercase
    /// - at least 1 lowercase
    /// - at least 1 number
    /// - at least 1 symbol (!&^%$#@()/_*+-)
    public func isNewPasswordValid() -> Bool {
        // swiftlint: disable line_length
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!&^%$#@()/_*+-])[A-Za-z\\d!&^%$#@()/_*+-]{8,36}$"
        // swiftlint: enable line_length
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: newPassword) && newPassword == newPasswordConfirmed
    }
    
    public func checkLength(
        str: String
    ) -> Bool {
        return str.count >= 8 && str.count <= 36
    }
    
    public func checkUpper(
        str: String
    ) -> Bool {
        return str.contains { $0.isUppercase }
    }
    
    public func checkLower(
        str: String
    ) -> Bool {
        return str.contains { $0.isLowercase }
    }
    
    public func checkNumber(
        str: String
    ) -> Bool {
        return str.contains { $0.isNumber }
    }
    
    public func checkSymbols(
        str: String
    ) -> Bool {
        let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
        let symbolChecker = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegEx)
        guard symbolChecker.evaluate(with: str) else { return false }
        return true
    }
}
