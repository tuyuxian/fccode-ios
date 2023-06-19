//
//  NationalityViewModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/10/23.
//

import Foundation

class NationalityViewModel: ObservableObject {
    var nationalities: [Nationality] = []
    
    var topNationalities: [Nationality] = [
        Nationality(name: "Canada", code: "CA"),
        Nationality(name: "Taiwan", code: "TW"),
        Nationality(name: "United States", code: "US")
    ]

    @Published var country = ""
    
    @Published var code = ""
    
    init() {
        loadCountryCode()
    }
    
    private func loadCountryCode() {
        let countryCodePath = Bundle.main.path(
            forResource: "countries",
            ofType: "json"
        )!
        
        do {
            let fileCountries = try? String(
                contentsOfFile: countryCodePath
            ).data(using: .utf8)!
            let decoder = JSONDecoder()
            nationalities = try decoder.decode(
                [Nationality].self,
                from: fileCountries!
            )
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
