//
//  Countries.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/4/23.
//

import SwiftUI

struct Country: Codable, Identifiable, Hashable{
    var id: UUID
    var name: String
    var code: String
    
    static let example = Country(id: UUID(), name: "Taiwan", code: "TW")
}
