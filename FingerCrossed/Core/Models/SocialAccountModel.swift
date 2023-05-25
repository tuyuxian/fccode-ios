//
//  SocialAccountModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/23/23.
//

import Foundation
import GraphQLAPI

enum SocialAccountPlatform {
    case FINGERCROSSED
    case FACEBOOK
    case GOOGLE
    case APPLE
    
    var graphQLValue: GraphQLAPI.SocialAccountPlatform {
        switch self {
        case .APPLE:
            return .apple
        case .FACEBOOK:
            return .facebook
        case .FINGERCROSSED:
            return .fingercrossed
        case .GOOGLE:
            return .google
        }
    }
}

struct SocialAccount {
    var id = UUID()
    var email: String
    var platform: SocialAccountPlatform
    
    init(
        email: String,
        platform: SocialAccountPlatform
    ) {
        self.email = email
        self.platform = platform
    }
}

extension SocialAccount {
    func getGraphQLInput() -> GraphQLAPI.CreateSocialAccountInput {
        return GraphQLAPI.CreateSocialAccountInput(
            email: self.email,
            platform: GraphQLEnum.case(self.platform.graphQLValue)
        )
    }
}
