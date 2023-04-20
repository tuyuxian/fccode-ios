//
//  FingerCrossedApp.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/6/23.
//

import SwiftUI

@main
struct FingerCrossedApp: App {
    var body: some Scene {
        WindowGroup {
            PairingView(candidateList: [CandidateModel(LifePhotoList: [LifePhoto(photoUrl: "https://img.freepik.com/free-photo/smiling-portrait-business-woman-beautiful_1303-2288.jpg?t=st=1681419194~exp=1681419794~hmac=72eb85b89df744cb0d7276e0a0c76a0f568c9e11d1f6b621303e0c6325a7f35c", caption: "caption1", position: 0), LifePhoto(photoUrl: "https://lifetouch.ca/wp-content/uploads/2015/03/photography-and-self-esteem.jpg", caption: "caption2", position: 1)], username: "UserName1", selfIntro: "Hi there! I'm a 25-year-old woman, born and raised in [City/State/Country]. I'm currently living in [City/State/Country], and I enjoy [hobbies/interests]. Nice to meet you!", gender: "Female", age: 30, location: "Tempe", nationality: "America"),CandidateModel(LifePhotoList: [LifePhoto(photoUrl: "https://img.freepik.com/free-photo/lovely-woman-white-dress_144627-23529.jpg?w=1800&t=st=1681804694~exp=1681805294~hmac=c33ecc06aa1daacd3995cbbadb1ef536b15cb90f1730332fea1f3ab717fbcd0d", caption: "caption1", position: 0), LifePhoto(photoUrl: "https://img.freepik.com/premium-photo/woman-sits-table-with-laptop-front-her-freelance-remote-work_401253-999.jpg?w=740", caption: "caption2", position: 1)], username: "UserName2", selfIntro: "Hi there! I'm a 25-year-old woman, born and raised in [City/State/Country]. I'm currently living in [City/State/Country], and I enjoy [hobbies/interests]. Nice to meet you!", gender: "Male", age: 35, location: "Chandler", nationality: "America")])
        }
    }
}
