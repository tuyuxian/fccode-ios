//
//  PreferenceSexOrientationViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/7/23.
//

import Foundation

class PreferenceSexOrientationViewModel: ObservableObject {
    
    /// Sex orientation option list
    let sexOrientationOptions: [String] = [
        "Everyone",
        "Man",
        "Woman",
        "Nonbinary people"
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
    
    /// Check Equality
    @Published var originalValue: [SexOrientation] = []
    private var checkList: [Bool] = []
    
    /// View state
    @Published var state: ViewStatus = .none
    @Published var showSaveButton: Bool = false
    
    /// Toast message
    @Published var toastMessage: String?
    @Published var toastType: Banner.BannerType?
}

extension PreferenceSexOrientationViewModel {
    
    public func getType(
        _ from: String
    ) -> SexOrientationType {
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
    
    public func checkEquality(sexOrientations: [SexOrientation]) {
        if sexOrientations.count == originalValue.count {
            sexOrientations.forEach { sexOrientation in
                checkList.append(originalValue.contains { item in
                    item.type == sexOrientation.type
                })
            }
            showSaveButton = checkList.contains(false)
            checkList = []
        } else {
            showSaveButton = true
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
