//
//  ProfileViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/13/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: UserEntityModel = UserEntityModel(
        id: UUID(),
        userId: 123123123,
        email: "test@gmail.com",
        password: "123123",
        username: "Test User",
        dateOfBirth: Date(),
        gender: .MALE,
        avatarURL: "https://i.pravatar.cc/150?img=6",
        selfIntro: "",
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
        lifePhoto: [],
        socialAccount: [],
        ethnicity: []
    )
    
    @Published var distance: String = ""
    @Published var ethnicity: [Ethnicity] = []
    @Published var goal: [String] = []
    @Published var sexOrientation: [String] = []
    @Published var ageFrom: Int = 18
    @Published var ageTo: Int = 100
    @Published var nationality = [CountryModel]()
    
}
