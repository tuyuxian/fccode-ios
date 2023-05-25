//
//  CountryModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/4/23.
//

import SwiftUI
import GraphQLAPI

class Nationality: Codable, Identifiable, Equatable, ObservableObject {
    static func == (
        lhs: Nationality,
        rhs: Nationality
    ) -> Bool {
        return lhs.id == rhs.id
    }
    
    @Published var id = UUID()
    @Published var name: String
    @Published var code: String

    init(
        name: String,
        code: String
    ) {
        self.name = name
        self.code = code
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case code
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        code = try container.decode(String.self, forKey: .code)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(code, forKey: .code)
    }
}

class NationalitySelectionList: ObservableObject, Equatable {
    static func == (
        lhs: NationalitySelectionList,
        rhs: NationalitySelectionList
    ) -> Bool {
        lhs.nationalitySelections == rhs.nationalitySelections
    }
    
    @Published var nationalitySelections = [Nationality]()
    
    init(nationalitySelections: [Nationality]) {
        self.nationalitySelections = nationalitySelections
    }
}

extension Nationality {
    func getGraphQLInput() -> GraphQLAPI.CreateCitizenInput {
        return GraphQLAPI.CreateCitizenInput(
            countryName: self.name
        )
    }
}