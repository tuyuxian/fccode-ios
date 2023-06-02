//
//  LifePhotoModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import Foundation
import GraphQLAPI

struct LifePhoto: Identifiable, Equatable {
    let id: UUID = UUID()
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
            offset: self.offset.width // TODO(Sam): add height
        )
    }
}
