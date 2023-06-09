//
//  PreferenceSexOrientationViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/7/23.
//

import Foundation
import SwiftUI

class PreferenceSexOrientationViewModel: ObservableObject {
    
    /// Sex orientation option list
    let sexOrientationOptions: [String] = [
        "Everyone",
        "Man",
        "Woman",
        "Nonbinary people"
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
        print("-> deinit preference sex orientation view model")
    }
}

extension PreferenceSexOrientationViewModel {
    public func getType(_ from: String) -> SexOrientationType {
        switch from {
        case "Man":
            return .SO2
        case "Woman":
            return .SO3
        case "Nonbinary people":
            return .SO4
        default:
            return .SO1
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
