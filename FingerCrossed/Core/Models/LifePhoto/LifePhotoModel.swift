//
//  LifePhotoModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import Foundation

struct LifePhoto: Identifiable, Equatable {
    let id: UUID
    var photoUrl: String
    var caption: String
    var position: Int
    
    init(
        id: UUID = UUID(),
        photoUrl: String,
        caption: String,
        position: Int
    ) {
        self.id = id
        self.photoUrl = photoUrl
        self.caption = caption
        self.position = position
    }
}
