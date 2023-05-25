//
//  PreferenceNationalityView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/11/23.
//

import SwiftUI

struct PreferenceNationalityView: View {
    /// Observed Profile view model
    @ObservedObject var vm: ProfileViewModel
    
    @StateObject var nationalitySelectionList = NationalitySelectionList(
        nationalitySelections: [Nationality]()
    )

    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Nationality",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            Box {
                VStack {
                    NationalityPicker(
                        nationalitySelectionList: nationalitySelectionList,
                        isPreference: true
                    )
                    .onChange(of: nationalitySelectionList.nationalitySelections) { _ in
                        vm.nationality = nationalitySelectionList.nationalitySelections
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}

struct PreferenceNationalityView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceNationalityView(vm: ProfileViewModel())
    }
}
