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
    
    @AppStorage("UserId") var userId: String = ""
    
    @Published var state: ViewStatus = .none
    @Published var errorMessage: String?

    @Published var user: User?
    
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

    deinit {
        print("-> profile view model deinit")
    }
}

extension ProfileViewModel {
    public func fetchUser() {
        DispatchQueue.main.async {
            self.state = .loading
        }
        Task {
            do {
                let user = try await GraphAPI.getUserById(userId: self.userId)
                guard let user = user else {
                    DispatchQueue.main.async {
                        self.state = .error
                        self.errorMessage = "Something went wrong"
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.user = user
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
    
    public func dummyUser() {
        DispatchQueue.main.async {
            self.user = User.MockUser
            self.state = .complete
        }
    }
}
