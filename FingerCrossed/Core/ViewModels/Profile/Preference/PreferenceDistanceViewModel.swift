//
//  PreferenceDistanceViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/7/23.
//

import Foundation

class PreferenceDistanceViewModel: ObservableObject {
    
    /// Distance option list
    let distanceOptions: [String] = [
        "Any",
        "25 miles",
        "50 miles",
        "75 miles",
        "100 miles"
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
    @Published var originalValue = ""
    
    /// View state
    @Published var state: ViewStatus = .none
    @Published var showSaveButton: Bool = false
    
    /// Toast message
    @Published var toastMessage: String?
    @Published var toastType: Banner.BannerType?

    init() {
        print("-> [Preference Distance] vm init")
    }
    
    deinit {
        print("-> [Preference Distance] vm deinit")
    }
}

extension PreferenceDistanceViewModel {
    
    public func getStringFromDistance(
        _ distance: Int
    ) -> String {
        switch distance {
        case 25:
            return "25 miles"
        case 50:
            return "50 miles"
        case 75:
            return "75 miles"
        case 100:
            return "100 miles"
        default:
            return "Any"
        }
    }

    public func getIntFromDistanceOption(
        _ distance: String
    ) -> Int {
        switch distance {
        case "25 miles":
            return 25
        case "50 miles":
            return 50
        case "75 miles":
            return 75
        case "100 miles":
            return 100
        default:
            return 0
        }
    }
    
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
