//
//  SocialAccountModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/23/23.
//

import Foundation
import GraphQLAPI

struct SocialAccount: Equatable {
    public var id = UUID()
    public var email: String
    public var platform: SocialAccountPlatform
    
    init(
        email: String,
        platform: SocialAccountPlatform
    ) {
        self.email = email
        self.platform = platform
    }
}

extension SocialAccount {
    public func getGraphQLInput() -> GraphQLAPI.CreateSocialAccountInput {
        return GraphQLAPI.CreateSocialAccountInput(
            email: self.email,
            platform: GraphQLEnum.case(self.platform.graphQLValue)
        )
    }
}
