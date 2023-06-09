//
//  AccountSheetViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/2/23.
//

import Foundation

class AccountSheetViewModel: ObservableObject {
    @Published var isSSO: Bool
    @Published var email: String?
    @Published var password: String = ""
    @Published var username: String?
    @Published var profilePictureUrl: String?
    @Published var showAppleSSO: Bool
    @Published var showFacebookSSO: Bool
    @Published var showGoogleSSO: Bool
    @Published var appleEmail: String?
    @Published var facebookEmail: String?
    @Published var googleEmail: String?
    @Published var isPasswordSatisfied: Bool = false
    
    init(
        isSSO: Bool = false,
        email: String? = nil,
        username: String? = nil,
        profilePictureUrl: String? = nil,
        showAppleSSO: Bool = false,
        showFacebookSSO: Bool = false,
        showGoogleSSO: Bool = false,
        appleEmail: String? = nil,
        facebookEmail: String? = nil,
        googleEmail: String? = nil
    ) {
        self.isSSO = isSSO
        self.email = email
        self.username = username
        self.profilePictureUrl = profilePictureUrl
        self.showAppleSSO = showAppleSSO
        self.showFacebookSSO = showFacebookSSO
        self.showGoogleSSO = showGoogleSSO
        self.appleEmail = appleEmail
        self.facebookEmail = facebookEmail
        self.googleEmail = googleEmail
    }
}
