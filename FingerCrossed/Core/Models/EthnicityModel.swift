//
//  EthnicityModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/23/23.
//

import Foundation

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
