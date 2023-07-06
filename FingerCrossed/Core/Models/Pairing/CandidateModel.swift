//
//  CandidateModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/12/23.
//

import Foundation

struct CandidateModel: Identifiable, Equatable {
    let id: UUID = UUID()
    var userId: String
    var username: String
    var selfIntro: String
    var gender: Gender
    var dateOfBirth: String
    var location: String
    var nationality: [Nationality]
    var voiceContentUrl: String?
    var lifePhotos: [LifePhoto]
    
    init (
        userId: String,
        username: String,
        selfIntro: String,
        gender: Gender,
        dateOfBirth: String,
        location: String,
        nationality: [Nationality],
        voiceContentUrl: String?,
        lifePhotos: [LifePhoto]
    ) {
        self.userId = userId
        self.username = username
        self.selfIntro = selfIntro
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.location = location
        self.nationality = nationality
        self.voiceContentUrl = voiceContentUrl
        self.lifePhotos = lifePhotos
    }
}

extension CandidateModel {
    public func getAge() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let dateOfBirth = dateFormatter.date(from: self.dateOfBirth) {
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: Date())
            if let age = ageComponents.year {
                return String(age)
            } else {
                return "--"
            }
        } else {
            return "--"
        }
    }
}

extension CandidateModel {
    static var MockCandidate: CandidateModel = .init(
        userId: "0",
        username: "Jacqueline",
        // swiftlint: disable line_length
        selfIntro: "Hi there! I'm a 25-year-old woman, born and raised in [City/State/Country]. I'm currently living in [City/State/Country], and I enjoy [hobbies/interests]. Nice to meet you!",
        // swiftlint: enable line_length
        gender: .female,
        dateOfBirth: "2000-01-01T00:00:00Z",
        location: "Oklahoma, OK",
        nationality: [
            Nationality(
                name: "United States",
                code: "US"
            )
        ],
        voiceContentUrl: "",
        lifePhotos: [LifePhoto.MockLifePhoto]
    )
}

extension CandidateModel {
    static var MockCandidates: [CandidateModel] = [
        .init(
            userId: "0",
            username: "Jacqueline",
            // swiftlint: disable line_length
            selfIntro: "Hi there! I'm a 25-year-old woman, born and raised in [City/State/Country]. I'm currently living in [City/State/Country], and I enjoy [hobbies/interests]. Nice to meet you!",
            // swiftlint: enable line_length
            gender: .female,
            dateOfBirth: "2000-01-01T00:00:00Z",
            location: "Oklahoma, OK",
            nationality: [
                Nationality(
                    name: "United States",
                    code: "US"
                )
            ],
            voiceContentUrl: "",
            lifePhotos: LifePhoto.MockLifePhotoList
        ),
        .init(
            userId: "0",
            username: "Jacqueline",
            // swiftlint: disable line_length
            selfIntro: "Hi there! I'm a 25-year-old woman, born and raised in [City/State/Country]. I'm currently living in [City/State/Country], and I enjoy [hobbies/interests]. Nice to meet you!",
            // swiftlint: enable line_length
            gender: .female,
            dateOfBirth: "2000-01-01T00:00:00Z",
            location: "Oklahoma, OK",
            nationality: [
                Nationality(
                    name: "United States",
                    code: "US"
                )
            ],
            voiceContentUrl: "",
            lifePhotos: LifePhoto.MockLifePhotoList
        )
    ]
}
