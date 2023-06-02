//
//  AccountSheetViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/2/23.
//

import Foundation

class AccountSheetViewModel: ObservableObject {
    @Published var isSSO: Bool = false
    @Published var email: String = "Test@gmail.com"
    @Published var password: String = ""
    @Published var profilePictureUrl: String = "https://i.pravatar.cc/150?img=6"
    @Published var showAppleSSO: Bool = false
    @Published var showFacebookSSO: Bool = false
    @Published var showGoogleSSO: Bool = false
    @Published var appleEmail: String?
    @Published var facebookEmail: String?
    @Published var googleEmail: String?
    @Published var isPasswordSatisfied: Bool = false
}
