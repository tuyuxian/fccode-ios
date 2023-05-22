//
//  ProfileViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/13/23.
//

import Foundation
import PhotosUI

class ProfileViewModel: ObservableObject, InputUtils {
    @Published var user: UserEntity = UserEntity(
        id: UUID(),
        userId: 123123123,
        email: "test@gmail.com",
        password: "123123",
        username: "Test User",
        dateOfBirth: Date(),
        gender: .MALE,
        avatarURL: "https://i.pravatar.cc/150?img=6",
        // swiftlint: disable line_length
        selfIntro: "Hello! I'm ChatGPT, a language model designed to understand and generate human-like language.",
        // swiftlint: enable line_length
        longitude: 123.0,
        latitude: 123.0,
        voiceContentURL: "",
        matchingDistance: 0,
        googleConnect: false,
        facebookConnect: false,
        appleConnect: false,
        premium: false,
        goal: [],
        citizen: [],
        lifePhoto: [
            LifePhoto(
                photoUrl: "https://i.pravatar.cc/150?img=6",
                caption: "123",
                position: 0
            ),
            LifePhoto(
                photoUrl: "https://i.pravatar.cc/150?img=7",
                caption: "123",
                position: 1
            ),
            LifePhoto(
                photoUrl: "https://i.pravatar.cc/150?img=8",
                caption: "123",
                position: 2
            ),
            LifePhoto(
                photoUrl: "https://i.pravatar.cc/150?img=9",
                caption: "",
                position: 3
            ),
            LifePhoto(
                photoUrl: "",
                caption: "",
                position: 4
            )
        ],
        socialAccount: [],
        ethnicity: []
    )
    // MARK: State Management
    @Published var currentPassword: String = ""
    @Published var newPassword: String = ""
    @Published var newPasswordConfirmed: String = ""
    
    // MARK: Condition Variables for button
    @Published var isNewPasswordSatisfied: Bool = false
    @Published var isCurrentPasswordMatched: Bool = false
    @Published var isNewPasswordLengthSatisfied: Bool = false
    @Published var isNewPasswordUpperAndLowerSatisfied: Bool = false
    @Published var isNewPasswordNumberAndSymbolSatisfied: Bool = false
    @Published var isNewPasswordMatched: Bool = false
    
    // MARK: Life Photo Sheet
    @Published var currentDragLifePhoto: LifePhoto?
    @Published var hasLifePhoto: Bool = false
    @Published var showEditSheet: Bool = false
    @Published var currentLifePhotoCount: Int = 4
    @Published var imageScale: CGFloat = 1
    @Published var selectedLifePhoto: LifePhoto?
    
    @Published var selectedImage: UIImage?
    @Published var selectedImageData: Data?
}
