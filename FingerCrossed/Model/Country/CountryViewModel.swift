//
//  CountryViewModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/10/23.
//

import Foundation

class CountryViewModel: ObservableObject {
    var countries = [CountryModel]()
    let sections = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    @Published var country = ""
    @Published var code = ""
    
    init() {
        loadCountryCode()
    }
    
    func loadCountryCode() {
        let countryCodePath = Bundle.main.path(forResource: "countries", ofType: "json")!
        
        do {
            let fileCountries = try? String(contentsOfFile: countryCodePath).data(using: .utf8)!
            let decoder = JSONDecoder()
            countries = try decoder.decode([CountryModel].self, from: fileCountries!)
        }
        catch {
            print(error)
        }
    }
}