//
//  GoalModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/24/23.
//

import Foundation

enum GoatlType {
    case GT1 // Serious relationship
    case GT2 // Casual relationship
    case GT3 // Situation relationship
    case GT4 // Meet new friends
    case GT5 // Boost Self-esteem
}

struct Goal {
    var id: UUID
    var goalID: Int
    var goalType: GoatlType
    
    init(
        id: UUID,
        goalID: Int,
        goalType: GoatlType
    ) {
        self.id = id
        self.goalID = goalID
        self.goalType = goalType
    }
    
    func getGoalType(
        goal: GoatlType
    ) -> String {
        switch goal {
        case .GT1:
            return "Serious relationship"
        case .GT2:
            return "Casual relationship"
        case .GT3:
            return "Situation relationship"
        case .GT4:
            return "Meet new friends"
        case .GT5:
            return "Boost Self-esteem"
        }
    }
}
