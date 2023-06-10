//
//  ProfileViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/13/23.
//

import Foundation
import PhotosUI
import SwiftUI

class ProfileViewModel: ObservableObject, InputProtocol {
    /// User state
    @AppStorage("UserId") var userId: String = ""
    @Published var user: User?
    
    /// View state
    @Published var state: ViewStatus = .none

    /// Toast message
    @Published var toastMessage: String?
    @Published var toastType: Banner.BannerType?
        
    // MARK: Life Photo Sheet
    @Published var currentDragLifePhoto: LifePhoto?
    @Published var hasLifePhoto: Bool = false
    @Published var showEditSheet: Bool = false
    @Published var currentLifePhotoCount: Int = 4
    @Published var imageScale: CGFloat = 1
    @Published var selectedLifePhoto: LifePhoto?
    @Published var imageOffset = CGSize.zero
    @Published var selectedImage: UIImage?
    @Published var selectedImageData: Data?
    
    init(preview: Bool = false) {
        print("-> [Profile] vm init")
        if !preview {
            Task { await fetchUser() }
        } else {
            dummyUser()
        }
    }
    
    deinit {
        print("-> [Profile] vm deinit")
    }
}

extension ProfileViewModel {
    @MainActor
    public func fetchUser() async {
        do {
            self.state = .loading
            let user = try await UserService.getUserById(userId: self.userId)
            guard let user = user else {
                showError()
                return
            }
            self.user = user
            self.state = .complete
        } catch {
            showError()
            print(error.localizedDescription)
        }
    }
    
    public func dummyUser() {
        self.user = User.MockUser
        self.state = .complete
    }

    private func showError() {
        self.state = .error
        self.toastType = .error
        self.toastMessage = "Something went wrong"
    }
}
