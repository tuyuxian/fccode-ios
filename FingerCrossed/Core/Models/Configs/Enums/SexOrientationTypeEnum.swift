//
//  SexOrientationTypeEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/29/23.
//

import Foundation

public enum SexOrientationType: CaseIterable {
    case SO1
    case SO2
    case SO3
    case SO4
    
    public func getString() -> String {
        switch self {
        case .SO1:
            return "Open to all"
        case .SO2:
            return "Heterosexuality"
        case .SO3:
            return "Bisexuality"
        case .SO4:
            return "Homosexuality"
        }
    }
}
