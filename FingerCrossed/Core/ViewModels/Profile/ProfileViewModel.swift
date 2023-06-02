//
//  ProfileViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/13/23.
//

import Foundation
import PhotosUI

class ProfileViewModel: ObservableObject, InputProtocol {
    @Published var user: User = User(
        userId: "123123123",
        email: "test@gmail.com",
        password: "123123",
        username: "Test User",
        dateOfBirth: "2000-01-10T17:30:15+05:30",
        gender: .MALE,
        profilePictureUrl: "https://i.pravatar.cc/150?img=6",
        // swiftlint: disable line_length
        selfIntro: "Hello! I'm ChatGPT, a language model designed to understand and generate human-like language.",
        // swiftlint: enable line_length
        longitude: 123.0,
        latitude: 123.0,
        country: "USA",
        administrativeArea: "AZ",
        voiceContentURL: "",
        googleConnect: false,
        facebookConnect: false,
        appleConnect: false,
        premium: false,
        goal: [],
        citizen: [],
        lifePhoto: [
            LifePhoto(
                contentUrl: "https://i.pravatar.cc/150?img=6",
                caption: "123",
                position: 0,
                scale: 1,
                offset: CGSize.zero
            ),
            LifePhoto(
                contentUrl: "https://i.pravatar.cc/150?img=7",
                caption: "123",
                position: 1,
                scale: 1,
                offset: CGSize.zero
            ),
            LifePhoto(
                contentUrl: "https://i.pravatar.cc/150?img=8",
                caption: "123",
                position: 2,
                scale: 1,
                offset: CGSize.zero
            ),
            LifePhoto(
                contentUrl: "https://i.pravatar.cc/150?img=9",
                caption: "",
                position: 3,
                scale: 1,
                offset: CGSize.zero
            ),
            LifePhoto(
                contentUrl: "",
                caption: "",
                position: 4,
                scale: 1,
                offset: CGSize.zero
            )
        ],
        socialAccount: [],
        ethnicity: []
    )
    
    @Published var distance: Int = 0
    @Published var ethnicity: [Ethnicity] = [Ethnicity(type: .ET0)]
    @Published var goal: [Goal] = [Goal(type: .GT0)]
    @Published var sexOrientation: [SexOrientation] = [SexOrientation(type: .SO1)]
    @Published var ageFrom: Int = 18
    @Published var ageTo: Int = 100
    @Published var nationality: [Nationality] = []
    
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
    @Published var imageOffset = CGSize.zero
    @Published var selectedImage: UIImage?
    @Published var selectedImageData: Data?
    
    public func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        if let date = ISO8601DateFormatter().date(from: self.user.dateOfBirth) {
            return dateFormatter.string(from: date)
        } else {
            return "Invalid timestamp"
        }
    }
}
