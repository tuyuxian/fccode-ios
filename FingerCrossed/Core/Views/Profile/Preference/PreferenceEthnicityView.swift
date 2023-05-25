//
//  PreferenceEthnicityView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceEthnicityView: View {
    /// Observed Profile view model
    @ObservedObject var vm: ProfileViewModel
    
    let ethnicityOptions: [String] = [
        "Open to all",
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

    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Ethnicity",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            Box {
                VStack(spacing: 0) {
                    CheckBoxWithDivider(items: ethnicityOptions) { list in
                        vm.ethnicity.removeAll()
                        for item in list {
                            let ethnicity = Ethnicity(id: UUID(), type: item)
                            vm.ethnicity.append(ethnicity)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 30)
                    
                    Spacer()
                }
            }
        }
    }
}

struct PreferenceEthnicityView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceEthnicityView(vm: ProfileViewModel())
    }
}
