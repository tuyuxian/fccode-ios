//
//  PreferenceModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/3/23.
//

import Foundation

struct Preference: Codable {
    /// Age
    var ageRange: AgeRange
    
    /// Distance
    var distance: Int
    
    /// Ethnicity
    var ethnicities: [Ethnicity]
    
    /// Goal
    var goals: [Goal]
    
    /// Nationality
    var nationalities: [Nationality]
    
    /// SexOrientation
    var sexOrientations: [SexOrientation]
    
}

struct AgeRange: Codable {
    var from: Int
    var to: Int
}

extension Preference {
    static var MockPreference: Preference = .init(
        ageRange: AgeRange(from: 18, to: 65),
        distance: 0,
        ethnicities: [],
        goals: [],
        nationalities: [],
        sexOrientations: [SexOrientation(type: .SO1)]
    )
}
