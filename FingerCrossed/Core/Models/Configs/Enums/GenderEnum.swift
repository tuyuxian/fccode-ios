//
//  GenderEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/26/23.
//

import Foundation
import GraphQLAPI

typealias Gender = UserGender

extension Gender: Codable {
    
    public func getString() -> String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .transgender:
            return "Transgender"
        case .nonBinary:
            return "Nonbinary"
        case .preferNotToSay:
            return "Prefer not to say"
        }
    }
    
}
