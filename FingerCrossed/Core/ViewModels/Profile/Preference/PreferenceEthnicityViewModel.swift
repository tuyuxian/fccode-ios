//
//  PreferenceEthnicityViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/7/23.
//

import Foundation

class PreferenceEthnicityViewModel: ObservableObject {
    
    /// Ethnicity option list
    let ethnicityOptions: [String] = [
        "Everyone",
        "American Indian",
        "Black/African American",
        "East Asian",
        "Hipanic/Latino",
        "Mid Eastern",
        "Pacific Islander",
        "South Asian",
        "Southeast Asian",
        "White/Caucasian"
    ]
    
    @Published var preference: Preference = {
        if let data = UserDefaults.standard.data(forKey: "UserMatchPreference") {
            do {
                let decoder = JSONDecoder()
                let preference = try decoder.decode(Preference.self, from: data)
                return preference
            } catch {
                print(error.localizedDescription)
            }
        }
        return Preference.MockPreference
    }()
    @Published var state: ViewStatus = .none
    @Published var errorMessage: String?
    @Published var showSaveButton: Bool = false
    
    deinit {
        print("-> deinit preference ethnicity view model")
    }
}

extension PreferenceEthnicityViewModel {
    public func getType(_ from: String) -> EthnicityType? {
        switch from {
        case "American Indian":
            return .et1
        case "Black/African American":
            return .et2
        case "East Asian":
            return .et3
        case "Hipanic/Latino":
            return .et4
        case "Mid Eastern":
            return .et5
        case "Pacific Islander":
            return .et6
        case "South Asian":
            return .et7
        case "Southeast Asian":
            return .et8
        case "White/Caucasian":
            return .et9
        default:
            return nil
        }
    }
    
    public func buttonOnTap() async {
        DispatchQueue.main.async {
            self.state = .loading
        }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self.preference)
            DispatchQueue.main.async {
                UserDefaults.standard.set(data, forKey: "UserMatchPreference")
                self.state = .complete
            }
        } catch {
            DispatchQueue.main.async {
                self.state = .error
                self.errorMessage = "Something went wrong"
            }
            print(error.localizedDescription)
        }
    }
}
