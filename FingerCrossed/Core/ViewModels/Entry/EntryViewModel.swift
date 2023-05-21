//
//  EntryViewModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/25/23.
//

import Foundation
import SwiftUI

class EntryViewModel: InputUtils, ObservableObject {
    // MARK: Enum section
    enum CurrentView: Int {
        case email
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
    
    // MARK: View control
    /// Default is forward transition
    @Published var transition: Transition = .forward
    /// Default entry view is email
    @Published var switchView: CurrentView = CurrentView.email
    
    // MARK: State Management
    @Published var isNewUser: Bool = true
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmed = ""
    @Published var newPassword: String = ""
    @Published var newPasswordConfirmed: String = ""
    @Published var name: String = ""
    @Published var dateOfBirth: String = ""
    @Published var selectedDate: Date = Date()
    @Published var gender: Gender?
    @Published var nationality = [CountryModel]()
    @Published var ethnicity = [Ethnicity]()
    @Published var avatarUrl: String?
    @Published var yearIndex = 99
    @Published var monthIndex = Calendar.current.component(.month, from: Date()) - 1
    @Published var dayIndex = Calendar.current.component(.day, from: Date()) - 1
    @Published var selectedImage: UIImage?
    @Published var selectedImageData: Data?
    
    // MARK: Condition Variables for button
    /// - Email view
    @Published var isEmailSatisfied: Bool = false
    /// - Password view
    @Published var isPasswordSatisfied: Bool = false
    /// - Sign up account view
    @Published var isAccountPasswordSatisfied: Bool = false
    @Published var isAccountPasswordLengthSatisfied: Bool = false
    @Published var isAccountPasswordUpperAndLowerSatisfied: Bool = false
    // swiftlint: disable identifier_name
    @Published var isAccountPasswordNumberAndSymbolSatisfied: Bool = false
    // swiftlint: enable identifier_name
    @Published var isAccountPasswordMatched: Bool = false
    /// - Sign up name view
    @Published var isNameSatisfied: Bool = false
    /// - Sign up birthday view
    @Published var isAdult: Bool = false
    /// - Sign up gender view
    @Published var isGenderSatisfied: Bool = false
    /// - Sign up ethnicity view
    @Published var isEthnicitySatisfied: Bool = false
    /// - Sign up nationality view
    @Published var isNationalitySatisfied: Bool = false
    /// - Sign up avatar view
    @Published var isAvatarSatisfied: Bool = false
    /// - Reset password view
    @Published var isNewPasswordSatisfied: Bool = false
    @Published var isNewPasswordLengthSatisfied: Bool = false
    @Published var isNewPasswordUpperAndLowerSatisfied: Bool = false
    @Published var isNewPasswordNumberAndSymbolSatisfied: Bool = false
    @Published var isNewPasswordMatched: Bool = false
}
