//
//  ProfileViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/13/23.
//

import Foundation
import PhotosUI
import SwiftUI

class ProfileViewModel: ObservableObject {
//    /// User state
//    @AppStorage("UserId") var userId: String = ""
//    @Published var user: User?
//
    /// View state
    @Published var state: ViewStatus = .loading

    /// Toast message
    @Published var toastMessage: String?
    @Published var toastType: Banner.BannerType?
    
//    init(preview: Bool = false) {
//        print("-> [Profile] vm init")
//        if !preview {
//            Task { await fetchUser() }
//        } else {
//            dummyUser()
//        }
//    }
//
    deinit {
        print("-> [Profile] vm deinit")
    }
}
