//
//  CandidateModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/12/23.
//

import Foundation

struct CandidateModel: Identifiable, Equatable{
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
