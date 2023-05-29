//
//  SocialAccountPlaformEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/26/23.
//

import Foundation
import GraphQLAPI

public enum SocialAccountPlatform: CaseIterable {
    case FINGERCROSSED
    case FACEBOOK
    case GOOGLE
    case APPLE
    
    public var graphQLValue: GraphQLAPI.SocialAccountPlatform {
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
