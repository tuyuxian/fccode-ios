//
//  GoalTypeEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/25/23.
//

import Foundation
import GraphQLAPI

public enum GoalType: CaseIterable {
    case GT0
    case GT1
    case GT2
    case GT3
    case GT4
    
    public func getString() -> String {
        switch self {
        case .GT0:
            return "Not sure yet"
        case .GT1:
            return "Serious relationship"
        case .GT2:
            return "Casual relationship"
        case .GT3:
            return "Situation relationship"
        case .GT4:
            return "Meet new friends"
        }
    }
    
    public var graphQLValue: GraphQLAPI.GoalGoalType {
        switch self {
        case .GT1:
            return .gt1
        case .GT2:
            return .gt2
        case .GT3:
            return .gt3
        case .GT4:
            return .gt4
        default:
            return .gt1
        }
    }
}
