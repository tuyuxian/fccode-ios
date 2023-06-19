//
//  EthnicityTypeEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/25/23.
//

import Foundation
import GraphQLAPI

typealias EthnicityType = EthnicityEthnicityType

extension EthnicityType: Codable {
    public func getString() -> String {
        switch self {
        case .et1:
            return "American Indian"
        case .et2:
            return "Black/African American"
        case .et3:
            return "East Asian"
        case .et4:
            return "Hipanic/Latino"
        case .et5:
            return "Mid Eastern"
        case .et6:
            return "Pacific Islander"
        case .et7:
            return "South Asian"
        case .et8:
            return "Southeast Asian"
        case .et9:
            return "White/Caucasian"
        }
    }
}
