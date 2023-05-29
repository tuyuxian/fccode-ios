//
//  PreferenceDistanceView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceDistanceView: View {
    /// Observed profile view model
    @ObservedObject var vm: ProfileViewModel
    /// Distance option list
    let distanceOptions: [String] = [
        "25 miles",
        "50 miles",
        "75 miles",
        "100 miles",
        "Any"
    ]
    /// Handler for save button on tap
    private func saveButtonOnTap() {
        
    }
    /// Helper to get distance option
    private func getStringFromDistance(
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
    /// Helper to get distance value
    private func getIntFromDistanceOption(
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
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Distance",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            Box {
                RadioButtonWithDivider(
                    items: distanceOptions,
                    selectedId: getStringFromDistance(vm.distance),
                    callback: { selected in
                        vm.distance = getIntFromDistanceOption(selected)
                    }
                )
                .padding(.vertical, 30)
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}

struct PreferenceDistanceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceDistanceView(
            vm: ProfileViewModel()
        )
    }
}
