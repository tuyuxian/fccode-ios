//
//  EthnicityModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/23/23.
//

import Foundation
import GraphQLAPI

enum EthnicityType: String, CaseIterable {
    case ET1 = "American Indian"
    case ET2 = "Black/African American"
    case ET3 = "East Asian"
    case ET4 = "Hipanic/Latino"
    case ET5 = "Mid Eastern"
    case ET6 = "Pacific Islander"
    case ET7 = "South Asian"
    case ET8 = "Southeast Asian"
    case ET9 = "White/Caucasian"
    
    var graphQLValue: GraphQLAPI.EthnicityEthnicityType {
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

struct Ethnicity: Equatable {
    var id: UUID
    var type: EthnicityType
    
    init(
        id: UUID,
        type: EthnicityType
    ) {
        self.id = id
        self.type = type
    }
}

extension Ethnicity {
    func getGraphQLInput() -> GraphQLAPI.CreateEthnicityInput {
        return GraphQLAPI.CreateEthnicityInput(
            ethnicityType: GraphQLEnum.case(self.type.graphQLValue)
        )
    }
}
