//
//  GoalTypeEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/25/23.
//

import Foundation
import GraphQLAPI

typealias GoalType = GraphQLAPI.GoalGoalType

extension GoalType: Codable {
    
    public func getString() -> String {
        switch self {
        case .gt1:
            return "Serious relationship"
        case .gt2:
            return "Casual relationship"
        case .gt3:
            return "Situation relationship"
        case .gt4:
            return "Meet new friends"
        }
    }
    
}
