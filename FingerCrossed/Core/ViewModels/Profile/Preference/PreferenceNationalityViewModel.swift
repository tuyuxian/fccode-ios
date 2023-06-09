//
//  PreferenceNationalityViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/7/23.
//

import Foundation

class PreferenceNationalityViewModel: ObservableObject {
    
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
        print("-> deinit preference nationality view model")
    }
}

extension PreferenceNationalityViewModel {
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
