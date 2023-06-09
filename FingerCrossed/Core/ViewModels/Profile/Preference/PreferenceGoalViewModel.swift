//
//  PreferenceGoalViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/7/23.
//

import Foundation

class PreferenceGoalViewModel: ObservableObject {
    
    /// Goal option list
    let goalOptions: [String] = [
        "Not sure yet",
        "Serious relationship",
        "Casual relationship",
        "Situation relationship",
        "Meet new friends"
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
        print("-> deinit preference goal view model")
    }
}

extension PreferenceGoalViewModel {
    public func getType(_ from: String) -> GoalType? {
        switch from {
        case "Serious relationship":
            return .gt1
        case "Casual relationship":
            return .gt2
        case "Situation relationship":
            return .gt3
        case "Meet new friends":
            return .gt4
        default:
            return nil
        }
    }
    // TODO(Sam): integrate graphql
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
