//
//  SexOrientationTypeEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/29/23.
//

import Foundation

public enum SexOrientationType: CaseIterable, Codable {
    case SO1
    case SO2
    case SO3
    case SO4
    
    public func getString() -> String {
        switch self {
        case .SO1:
            return "Everyone"
        case .SO2:
            return "Man"
        case .SO3:
            return "Woman"
        case .SO4:
            return "Nonbinary people"
        }
    }
}
