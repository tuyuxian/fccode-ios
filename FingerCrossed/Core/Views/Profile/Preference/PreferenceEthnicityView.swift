//
//  PreferenceEthnicityView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceEthnicityView: View {
    /// View controller
    @Environment(\.presentationMode) var presentationMode
    /// Global banner
    @EnvironmentObject var bm: BannerManager
    /// Observed profile view model
    @ObservedObject var vm: ProfileViewModel
    /// Flag to show up save button
    @State private var showSaveButton: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Ethnicity option list
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
    /// Handler for save button on tap
    private func saveButtonOnTap() {
        // TODO(Sam): integrate graphql
        presentationMode.wrappedValue.dismiss()
    }

    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Ethnicity",
            showSaveButton: $showSaveButton,
            isLoading: $isLoading,
            action: saveButtonOnTap
        ) {
            Box {
                VStack(spacing: 0) {
                    CheckBoxWithDivider(
                        items: ethnicityOptions,
                        selectedIdList: Array(
                            vm.ethnicity.map { $0.type.getString() }
                        ),
                        callback: { list in
                            vm.ethnicity.removeAll()
                            for item in list {
                                vm.ethnicity.append(
                                    Ethnicity(
                                        type: EthnicityType.allCases.first(where: {
                                            $0.getString() == item
                                        }) ?? .ET0
                                    )
                                )
                            }
                        }
                    )
                    .padding(.horizontal, 24)
                    .padding(.vertical, 30)
                    .onChange(of: vm.ethnicity) { _ in
                        showSaveButton = true
                    }
                    
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
