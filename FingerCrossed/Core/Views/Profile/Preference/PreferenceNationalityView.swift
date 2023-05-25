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
    
    @StateObject var countrySelectionList = CountrySelectionList(countrySelections: [CountryModel]())

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
                        countrySelectionList: countrySelectionList,
                        isPreference: true
                    )
                    .onChange(of: countrySelectionList.countrySelections) { _ in
                        vm.nationality = countrySelectionList.countrySelections
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
