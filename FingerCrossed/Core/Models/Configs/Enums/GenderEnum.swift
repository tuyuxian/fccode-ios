//
//  GenderEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/26/23.
//

import Foundation
import GraphQLAPI

public enum Gender: CaseIterable {
    case MALE
    case FEMALE
    case TRANSGENDER
    case NONBINARY
    case PREFERNOTTOSAY
    
    public func getString() -> String {
        switch self {
        case .MALE:
            return "Male"
        case .FEMALE:
            return "Female"
        case .TRANSGENDER:
            return "Transgender"
        case .NONBINARY:
            return "Nonbinary"
        case .PREFERNOTTOSAY:
            return "Prefer not to say"
        }
    }
    
    public var graphQLValue: GraphQLAPI.UserGender {
        switch self {
        case .MALE:
            return .male
        case .FEMALE:
            return .female
        case .TRANSGENDER:
            return .transgender
        case .NONBINARY:
            return .nonBinary
        case .PREFERNOTTOSAY:
            return .preferNotToSay
        }
    }
}
