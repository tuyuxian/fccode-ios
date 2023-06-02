//
//  UserModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/23/23.
//

import Foundation
import GraphQLAPI

struct User {
    public var id: UUID = UUID()
    public var userId: String
    public var email: String
    public var password: String?
    public var username: String
    public var dateOfBirth: String
    public var gender: Gender
    public var profilePictureUrl: String?
    public var selfIntro: String?
    public var longitude: Double
    public var latitude: Double
    public var country: String?
    public var administrativeArea: String?
    public var voiceContentURL: String?
    public var googleConnect: Bool
    public var facebookConnect: Bool
    public var appleConnect: Bool
    public var premium: Bool
    public var goal: [Goal]
    public var citizen: [Nationality]
    public var lifePhoto: [LifePhoto]
    public var socialAccount: [SocialAccount]
    public var ethnicity: [Ethnicity]
    
    init(
        userId: String,
        email: String,
        password: String?,
        username: String,
        dateOfBirth: String,
        gender: Gender,
        profilePictureUrl: String?,
        selfIntro: String,
        longitude: Double,
        latitude: Double,
        country: String,
        administrativeArea: String,
        voiceContentURL: String?,
        googleConnect: Bool,
        facebookConnect: Bool,
        appleConnect: Bool,
        premium: Bool,
        goal: [Goal],
        citizen: [Nationality],
        lifePhoto: [LifePhoto],
        socialAccount: [SocialAccount],
        ethnicity: [Ethnicity]
    ) {
        self.userId = userId
        self.email = email
        self.password = password
        self.username = username
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.profilePictureUrl = profilePictureUrl
        self.selfIntro = selfIntro
        self.longitude = longitude
        self.latitude = latitude
        self.country = country
        self.administrativeArea = administrativeArea
        self.voiceContentURL = voiceContentURL
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

extension User {
    public func getGraphQLInput() -> GraphQLAPI.CreateUserInput {
        return GraphQLAPI.CreateUserInput(
            email: self.email,
            password: self.password != nil && self.password != "" ? .some(self.password!) : nil,
            username: self.username,
            dateOfBirth: self.dateOfBirth,
            gender: GraphQLEnum.case(self.gender.graphQLValue),
            profilePictureURL: self.profilePictureUrl != nil ? .some(self.profilePictureUrl!) : nil,
            longitude: self.longitude,
            latitude: self.latitude,
            country: self.country != nil ? .some(self.country!) : nil,
            administrativeArea: self.administrativeArea != nil ? .some(self.administrativeArea!) : nil,
            googleConnect: .some(self.googleConnect),
            appleConnect: .some(self.appleConnect),
            createUserCitizen: .some(
                self.citizen.map { $0.getGraphQLInput() }
            ),
            createUserEthnicity: .some(
                self.ethnicity.map { $0.getGraphQLInput() }
            ),
            createUserSocialAccount: (self.socialAccount.first?.getGraphQLInput())!,
            createUserLifePhoto: (self.lifePhoto.first?.getGraphQLInput())!
        )
    }
}
