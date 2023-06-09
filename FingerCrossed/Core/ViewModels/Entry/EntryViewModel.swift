//
//  EntryViewModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/25/23.
//

import Foundation
import SwiftUI

class EntryViewModel: ObservableObject, InputProtocol {
    // MARK: Enum section
    enum CurrentView: Int {
        case email
        case password
        case resetPassword
        case resetPasswordEmailCheck
        case resetPasswordOTP
        case account
        case name
        case birthday
        case gender
        case ethnicity
        case nationality
        case avatar
        case location
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
    @Published var user: User = User(
        userId: "0",
        email: "",
        password: "",
        username: "",
        dateOfBirth: "",
        gender: .MALE,
        profilePictureUrl: "",
        selfIntro: "",
        longitude: 0,
        latitude: 0,
        country: "",
        administrativeArea: "",
        voiceContentURL: "",
        googleConnect: false,
        facebookConnect: false,
        appleConnect: false,
        premium: false,
        goal: [],
        citizen: [],
        lifePhoto: [],
        socialAccount: [],
        ethnicity: []
    )
    @Published var password = ""
    @Published var passwordConfirmed = ""
    @Published var newPassword: String = ""
    @Published var newPasswordConfirmed: String = ""
    @Published var selectedDate: Date = Date()
    @Published var gender: Gender?
    @Published var yearIndex = 99
    @Published var monthIndex = Calendar.current.component(.month, from: Date()) - 1
    @Published var dayIndex = Calendar.current.component(.day, from: Date()) - 1
    @Published var selectedImage: UIImage?

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
    
    deinit {
        print("-> EntryViewModel deinit")
    }
    
    public func reinit() {
        self.user = User(
            userId: "0",
            email: "",
            password: "",
            username: "",
            dateOfBirth: "",
            gender: .MALE,
            profilePictureUrl: "",
            selfIntro: "",
            longitude: 0,
            latitude: 0,
            country: "",
            administrativeArea: "",
            voiceContentURL: "",
            googleConnect: false,
            facebookConnect: false,
            appleConnect: false,
            premium: false,
            goal: [],
            citizen: [],
            lifePhoto: [],
            socialAccount: [],
            ethnicity: []
        )
        self.password = ""
        self.passwordConfirmed = ""
        self.newPassword = ""
        self.newPasswordConfirmed = ""
        self.selectedDate = Date()
        self.gender = nil
        self.yearIndex = 99
        self.monthIndex = Calendar.current.component(.month, from: Date()) - 1
        self.dayIndex = Calendar.current.component(.day, from: Date()) - 1
        self.selectedImage = nil
        self.isEmailSatisfied = false
        self.isPasswordSatisfied = false
        self.isAccountPasswordSatisfied = false
        self.isAccountPasswordLengthSatisfied = false
        self.isAccountPasswordUpperAndLowerSatisfied = false
        self.isAccountPasswordNumberAndSymbolSatisfied = false
        self.isAccountPasswordMatched = false
        self.isNameSatisfied = false
        self.isAdult = false
        self.isGenderSatisfied = false
        self.isEthnicitySatisfied = false
        self.isNationalitySatisfied = false
        self.isAvatarSatisfied = false
        self.isNewPasswordSatisfied = false
        self.isNewPasswordLengthSatisfied = false
        self.isNewPasswordUpperAndLowerSatisfied = false
        self.isNewPasswordNumberAndSymbolSatisfied = false
        self.isNewPasswordMatched = false
    }
}
