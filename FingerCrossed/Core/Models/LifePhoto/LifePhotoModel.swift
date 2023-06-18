//
//  LifePhotoModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import Foundation
import GraphQLAPI

struct LifePhoto: Identifiable, Equatable, Codable {
    var id: UUID = UUID()
    var contentUrl: String
    var caption: String
    var position: Int
    var scale: CGFloat
    var offset: CGSize
    
    init(
        contentUrl: String,
        caption: String,
        position: Int,
        scale: CGFloat,
        offset: CGSize
    ) {
        self.contentUrl = contentUrl
        self.caption = caption
        self.position = position
        self.scale = scale
        self.offset = offset
    }
}

extension LifePhoto {
    public func getGraphQLInput() -> GraphQLAPI.CreateLifePhotoInput {
        return GraphQLAPI.CreateLifePhotoInput(
            contentURL: self.contentUrl,
            caption: .some(self.caption),
            position: self.position,
            scale: self.scale,
            offsetX: self.offset.width,
            offsetY: self.offset.height
        )
    }
}

extension LifePhoto {
    static var MockLifePhoto: LifePhoto = .init(
        contentUrl: "https://i.pravatar.cc/150?img=9",
        caption: "0",
        position: 0,
        scale: 1,
        offset: CGSize.zero
    )
    
    static var MockLifePhotoList: [LifePhoto] = [
        .init(
            contentUrl: "https://i.pravatar.cc/150?img=9",
            caption: "0",
            position: 0,
            scale: 1,
            offset: CGSize.zero
        ),
        .init(
            contentUrl: "https://i.pravatar.cc/150?img=10",
            caption: "1",
            position: 1,
            scale: 1,
            offset: CGSize.zero
        ),
        .init(
            contentUrl: "https://i.pravatar.cc/150?img=11",
            caption: "2",
            position: 2,
            scale: 1,
            offset: CGSize.zero
        )
    ]
}
