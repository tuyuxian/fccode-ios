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
        lifePhotos: [
            LifePhoto(
                id: "0",
                contentUrl: "https://d2yydc9fog8bo7.cloudfront.net/image/f4d0056c-091f-4c2f-a707-e45b35f70337.jpg",
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
                caption: "test",
                position: 3,
                ratio: 3,
                scale: 1,
                offset: CGSize.zero
            )
        ]
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
            lifePhotos: [
                LifePhoto(
                    id: "0",
                    contentUrl: "https://d2yydc9fog8bo7.cloudfront.net/image/f4d0056c-091f-4c2f-a707-e45b35f70337.jpg",
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
                    caption: "test",
                    position: 3,
                    ratio: 3,
                    scale: 1,
                    offset: CGSize.zero
                )
            ]
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
            lifePhotos: [
                LifePhoto(
                    id: "0",
                    contentUrl: "https://d2yydc9fog8bo7.cloudfront.net/image/f4d0056c-091f-4c2f-a707-e45b35f70337.jpg",
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
                    caption: "test",
                    position: 3,
                    ratio: 3,
                    scale: 1,
                    offset: CGSize.zero
                )
            ]
        )
    ]
}
