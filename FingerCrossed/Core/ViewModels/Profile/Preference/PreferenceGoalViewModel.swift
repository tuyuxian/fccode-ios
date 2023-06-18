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
    
    /// Preference state
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
        return Preference.MockPreference // for preview purpose
    }()
    @Published var originalValue: [Goal] = []
    
    /// View state
    @Published var state: ViewStatus = .none
    @Published var showSaveButton: Bool = false
    
    /// Toast message
    @Published var toastMessage: String?
    @Published var toastType: Banner.BannerType?
    
    init() {
        print("-> [Preference Goal] vm init")
    }
    
    deinit {
        print("-> [Preference Goal] vm deinit")
    }
}

extension PreferenceGoalViewModel {
    
    public func getType(
        _ from: String
    ) -> GoalType? {
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
    @MainActor
    public func save() async {
        do {
            self.state = .loading
            let encoder = JSONEncoder()
            let data = try encoder.encode(self.preference)
            UserDefaults.standard.set(data, forKey: "UserMatchPreference")
            self.state = .complete
        } catch {
            self.state = .error
            self.toastMessage = "Something went wrong"
            self.toastType = .error
            print(error.localizedDescription)
        }
    }
}
