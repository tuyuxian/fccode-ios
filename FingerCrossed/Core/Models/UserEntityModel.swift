//
//  UserEntityModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/23/23.
//

import Foundation

enum Gender: String, CaseIterable {
    case MALE = "Male"
    case FEMALE = "Female"
    case TRANSGENDER = "Transgender"
    case NONBINARY = "Nonbinary"
    case PREFERNOTTOSAY = "Prefer not to say"
}

class UserEntity: ObservableObject {
    var id: UUID
    var userId: Int?
    var email: String?
    var password: String?
    var username: String?
    var dateOfBirth: Date?
    var gender: Gender?
    var avatarURL: String?
    var selfIntro: String?
    var longitude: Float?
    var latitude: Float?
    var voiceContentURL: String?
    var matchingDistance: Int?
    var googleConnect: Bool?
    var facebookConnect: Bool?
    var appleConnect: Bool?
    var premium: Bool?
    var goal: [GoalModel]
    var citizen: [CountryModel]
    var lifePhoto: [LifePhoto]
    var socialAccount: [SocialAccount]
    var ethnicity: [Ethnicity]
    
    init(
        id: UUID,
        userId: Int,
        email: String,
        password: String,
        username: String,
        dateOfBirth: Date,
        gender: Gender,
        avatarURL: String,
        selfIntro: String,
        longitude: Float,
        latitude: Float,
        voiceContentURL: String,
        matchingDistance: Int,
        googleConnect: Bool,
        facebookConnect: Bool,
        appleConnect: Bool,
        premium: Bool,
        goal: [GoalModel],
        citizen: [CountryModel],
        lifePhoto: [LifePhoto],
        socialAccount: [SocialAccount],
        ethnicity: [Ethnicity]
    ) {
        self.id = id
        self.email = email
        self.password = password
        self.username = username
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.avatarURL = avatarURL
        self.selfIntro = selfIntro
        self.longitude = longitude
        self.latitude = latitude
        self.voiceContentURL = voiceContentURL
        self.matchingDistance = matchingDistance
        self.googleConnect = googleConnect
        self.facebookConnect = facebookConnect
        self.appleConnect = appleConnect
        self.premium = premium
        self.goal = goal
        self.citizen = citizen
        self.lifePhoto = lifePhoto
        self.socialAccount = socialAccount
        self.ethnicity = ethnicity
    }
}
