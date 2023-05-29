//
//  EthnicityTypeEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/25/23.
//

import Foundation
import GraphQLAPI

public enum EthnicityType: CaseIterable {
    case ET1
    case ET2
    case ET3
    case ET4
    case ET5
    case ET6
    case ET7
    case ET8
    case ET9
    
    public func getString() -> String {
        switch self {
        case .ET1:
            return "American Indian"
        case .ET2:
            return "Black/African American"
        case .ET3:
            return "East Asian"
        case .ET4:
            return "Hipanic/Latino"
        case .ET5:
            return "Mid Eastern"
        case .ET6:
            return "Pacific Islander"
        case .ET7:
            return "South Asian"
        case .ET8:
            return "Southeast Asian"
        case .ET9:
            return "White/Caucasian"
        }
    }
    
    public var graphQLValue: GraphQLAPI.EthnicityEthnicityType {
        switch self {
        case .ET1:
            return .et1
        case .ET2:
            return .et2
        case .ET3:
            return .et3
        case .ET4:
            return .et4
        case .ET5:
            return .et5
        case .ET6:
            return .et6
        case .ET7:
            return .et7
        case .ET8:
            return .et8
        case .ET9:
            return .et9
        }
    }
}
