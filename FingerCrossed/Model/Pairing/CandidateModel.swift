//
//  CandidateModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/12/23.
//

import Foundation

struct CandidateModel: Identifiable, Equatable {
    let id: UUID
    var lifePhotoList: [LifePhoto]
    var username: String
    var selfIntro: String
    var gender: String
    var age: Int
    var location: String
    var nationality: String
    
    init (
        id: UUID = UUID(),
        lifePhotoList: [LifePhoto],
        username: String,
        selfIntro: String,
        gender: String,
        age: Int, location:
        String,
        nationality: String
    ) {
        self.id = id
        self.lifePhotoList = lifePhotoList
        self.username = username
        self.selfIntro = selfIntro
        self.gender = gender
        self.age = age
        self.location = location
        self.nationality = nationality
    }
}
