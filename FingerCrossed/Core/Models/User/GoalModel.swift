//
//  GoalModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/24/23.
//

import Foundation
import GraphQLAPI

struct Goal {
    public var id: UUID = UUID()
    public var type: GoalType
    
    init(
        type: GoalType
    ) {
        self.type = type
    }
}

extension Goal {
    public func getGraphQLInput() -> GraphQLAPI.CreateGoalInput {
        return GraphQLAPI.CreateGoalInput(
            goalType: GraphQLEnum.case(self.type.graphQLValue)
        )
    }
}