//
//  SocialAccountModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/23/23.
//

import Foundation

enum SocialAccountPlatform {
    case FINGERCROSSED
    case FACEBOOK
    case GOOGLE
    case APPLE
}

struct SocialAccount {
    var id: UUID
    var email: String
    var platform: SocialAccountPlatform
    
    init(
        id: UUID,
        email: String,
        platform: SocialAccountPlatform
    ) {
        self.id = id
        self.email = email
        self.platform = platform
    }
}
