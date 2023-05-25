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
    var scale: CGFloat
    var offset: CGSize
    
    init(
        id: UUID = UUID(),
        photoUrl: String,
        caption: String,
        position: Int,
        scale: CGFloat,
        offset: CGSize
    ) {
        self.id = id
        self.photoUrl = photoUrl
        self.caption = caption
        self.position = position
        self.scale = scale
        self.offset = offset
    }
}
