//
//  UserViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/16/23.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    
    @AppStorage("UserId") var userId: String = ""
    
    @Published var data: User?
    
    /// View state
    @Published var state: ViewStatus = .none

    /// Toast message
    @Published var toastMessage: String?
    @Published var toastType: Banner.BannerType?
    
    init(preview: Bool = false) {
        print("-> [User] vm init")
        if !preview {
            Task { await fetchUser() }
        } else {
            dummyUser()
        }
    }

    deinit {
        print("-> [User] vm deinit")
    }
}

extension UserViewModel {
    
    @MainActor
    public func fetchUser() async {
        Task {
            do {
                self.state = .loading
                let user = try await UserService.getUserById(userId: self.userId)
                guard let user = user else {
                    throw FCError.User.getUserFailed
                }
                self.data = user
                self.state = .complete
            } catch {
                self.state = .error
                self.toastMessage = "Something went wrong"
                self.toastType = .error
                print(error.localizedDescription)
            }
        }
    }
    
    public func dummyUser() {
        self.data = User.MockUser
    }
}
