//
//  Crop.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/22/23.
//

import SwiftUI

enum Crop: Equatable {
    case type1
    case type2
    case type3
    case type4
    
    func name() -> String {
        switch self {
        case .type1:
            return "3:4"
        case .type2:
            return "4:3"
        case .type3:
            return "9:16"
        case .type4:
            return "16:9"
        }
    }
    
    func tag() -> Int {
        switch self {
        case .type1:
            return 0
        case .type2:
            return 1
        case .type3:
            return 2
        case .type4:
            return 3
        }
    }
    
    static func tagToType(tag: Int) -> Crop {
        switch tag {
        case 0:
            return .type1
        case 1:
            return .type2
        case 2:
            return .type3
        case 3:
            return .type4
        default:
            return .type1
        }
    }
    
    func size() -> CGSize {
        switch self {
        case .type1:
            return .init(
                width: (UIScreen.main.bounds.width - 48),
                height: (UIScreen.main.bounds.width - 48) * 4 / 3)
        case .type2:
            return .init(
                width: (UIScreen.main.bounds.width - 48),
                height: (UIScreen.main.bounds.width - 48) * 3 / 4)
        case .type3:
            return .init(
                width: (UIScreen.main.bounds.height - 320) * 9 / 16,
                height: (UIScreen.main.bounds.height - 320))
        case .type4:
            return .init(
                width: (UIScreen.main.bounds.width - 48),
                height: (UIScreen.main.bounds.width - 48) * 9 / 16)
        }
    }
}
