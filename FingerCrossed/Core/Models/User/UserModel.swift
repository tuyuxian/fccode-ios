//
//  UserModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/23/23.
//

import Foundation
import GraphQLAPI

struct User: Codable {
    public var id: String
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
        id: String,
        email: String,
        password: String?,
        username: String,
        dateOfBirth: String,
        gender: Gender,
        profilePictureUrl: String?,
        selfIntro: String?,
        longitude: Double,
        latitude: Double,
        country: String?,
        administrativeArea: String?,
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
        self.id = id
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
    public func getGraphQLInput() -> CreateUserInput {
        return CreateUserInput(
            email: self.email,
            password: self.password != nil && self.password != "" ? .some(self.password!) : nil,
            username: self.username,
            dateOfBirth: self.dateOfBirth,
            gender: GraphQLEnum.case(self.gender),
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
    
    public func getBirthdayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = ISO8601DateFormatter().date(from: self.dateOfBirth) {
            return dateFormatter.string(from: date)
        } else {
            return "--/--/----"
        }
    }
}

extension User {
    public func getCandidate() -> CandidateModel {
        return .init(
            userId: self.id,
            username: self.username,
            selfIntro: self.selfIntro ?? "",
            gender: self.gender,
            dateOfBirth: self.dateOfBirth,
            location: "\(self.administrativeArea ?? ""), \( self.country ?? "")",
            nationality: self.citizen,
            voiceContentUrl: self.voiceContentURL,
            lifePhotos: self.lifePhoto
        )
    }
}

extension User {
    static var MockUser: User = .init(
        id: "00000000001",
        email: "mock_user1@gmail.com",
        password: "$2a$14$aR/BWx54TyKXWX5/exO05eU6vb.l.EsohuPJGr2N.GrRC6u5BF0ze",
        username: "Mock User1",
        dateOfBirth: "2000-01-01T00:00:00Z",
        gender: .male,
        profilePictureUrl: "",
        // swiftlint: disable line_length
        selfIntro: "Hello! I'm ChatGPT, a language model designed to understand and generate human-like language.",
        // swiftlint: enable line_length
        longitude: -122.406417,
        latitude: 37.785834,
        country: "United States",
        administrativeArea: "CA",
        voiceContentURL: "",
        googleConnect: false,
        facebookConnect: false,
        appleConnect: false,
        premium: false,
        goal: [
            Goal(type: .gt1)
        ],
        citizen: [
            Nationality(
                name: "United States",
                code: "US"
            )
        ],
        lifePhoto: [
            LifePhoto(
                id: "0",
                contentUrl: "https://i.pravatar.cc/150?img=6",
                caption: "123",
                position: 0,
                ratio: 3,
                scale: 1,
                offset: CGSize.zero
            ),
            LifePhoto(
                id: "1",
                contentUrl: "https://i.pravatar.cc/150?img=7",
                caption: "123",
                position: 1,
                ratio: 3,
                scale: 1,
                offset: CGSize.zero
            ),
            LifePhoto(
                id: "2",
                contentUrl: "https://i.pravatar.cc/150?img=8",
                caption: "123",
                position: 2,
                ratio: 3,
                scale: 1,
                offset: CGSize.zero
            ),
            LifePhoto(
                id: "3",
                contentUrl: "https://i.pravatar.cc/150?img=9",
                caption: "",
                position: 3,
                ratio: 3,
                scale: 1,
                offset: CGSize.zero
            )
        ],
        socialAccount: [],
        ethnicity: [
            Ethnicity(type: .et1)
        ]
    )
}
