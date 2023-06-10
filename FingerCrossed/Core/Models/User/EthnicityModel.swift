//
//  EthnicityModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/23/23.
//

import Foundation
import GraphQLAPI

struct Ethnicity: Equatable, Codable {
    public var id: UUID = UUID()
    public var type: EthnicityType
    
    init(
        type: EthnicityType
    ) {
        self.type = type
    }
}

extension Ethnicity {
    public func getGraphQLInput() -> GraphQLAPI.CreateEthnicityInput {
        return GraphQLAPI.CreateEthnicityInput(
            ethnicityType: GraphQLEnum.case(self.type)
        )
    }
}
