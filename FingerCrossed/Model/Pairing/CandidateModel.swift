//
//  CandidateModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/12/23.
//

import Foundation

struct CandidateModel {
    let id: UUID
    var LifePhotoList: [LifePhoto]
    var username: String
    var selfIntro: String
    var gender: String
    var age: Int
    var location: String
    var nationality: String
    
    init(id: UUID = UUID(), LifePhotoList: [LifePhoto], username: String, selfIntro: String, gender: String, age: Int, location: String, nationality: String) {
        self.id = id
        self.LifePhotoList = LifePhotoList
        self.username = username
        self.selfIntro = selfIntro
        self.gender = gender
        self.age = age
        self.location = location
        self.nationality = nationality
    }
}

struct LifePhoto {
    let id: UUID
    var photoUrl: String
    var caption: String
    var position: Int
    
    init(id: UUID = UUID(), photoUrl: String, caption: String, position: Int) {
        self.id = id
        self.photoUrl = photoUrl
        self.caption = caption
        self.position = position
    }
}
