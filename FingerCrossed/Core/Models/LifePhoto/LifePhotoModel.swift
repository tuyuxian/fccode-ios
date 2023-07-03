//
//  LifePhotoModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import Foundation
import GraphQLAPI

struct LifePhoto: Identifiable, Equatable, Codable {
    var id: String
    var contentUrl: String
    var caption: String
    var position: Int
    var ratio: Int
    var scale: CGFloat
    var offset: CGPoint
    
    init(
        id: String,
        contentUrl: String,
        caption: String,
        position: Int,
        ratio: Int,
        scale: CGFloat,
        offset: CGPoint
    ) {
        self.id = id
        self.contentUrl = contentUrl
        self.caption = caption
        self.ratio = ratio
        self.position = position
        self.scale = scale
        self.offset = offset
    }
}

extension LifePhoto {
    public func getGraphQLInput() -> CreateLifePhotoInput {
        return CreateLifePhotoInput(
            contentURL: self.contentUrl,
            caption: .some(self.caption),
            position: self.position,
            ratio: self.ratio,
            scale: self.scale,
            offsetX: self.offset.x,
            offsetY: self.offset.y
        )
    }
}

extension LifePhoto {
    static var MockLifePhoto: LifePhoto = .init(
        id: "0",
        contentUrl: "https://i.pravatar.cc/150?img=9",
        caption: "0",
        position: 0,
        ratio: 3,
        scale: 1,
        offset: CGPoint.zero
    )
    
    static var MockLifePhotoList: [LifePhoto] = [
        .init(
            id: "0",
            contentUrl: "https://i.pravatar.cc/150?img=9",
            caption: "0",
            position: 0,
            ratio: 3,
            scale: 1,
            offset: CGPoint.zero
        ),
        .init(
            id: "1",
            contentUrl: "https://i.pravatar.cc/150?img=10",
            caption: "1",
            position: 1,
            ratio: 3,
            scale: 1,
            offset: CGPoint.zero
        ),
        .init(
            id: "2",
            contentUrl: "https://i.pravatar.cc/150?img=11",
            caption: "2",
            position: 2,
            ratio: 3,
            scale: 1,
            offset: CGPoint.zero
        )
    ]
}
