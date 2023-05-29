//
//  PreferenceNationalityView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/11/23.
//

import SwiftUI

struct PreferenceNationalityView: View {
    /// View controller
    @Environment(\.presentationMode) var presentationMode
    /// Global banner
    @EnvironmentObject var bm: BannerManager
    /// Observed profile view model
    @ObservedObject var vm: ProfileViewModel
    /// Flag to show up save button
    @State private var showSaveButton: Bool = false
    /// Nationality list
    @State var nationalityList: [Nationality] = []
    
    // TODO(Lawerence): apply new design
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
                        nationalityList: $nationalityList,
                        isPreference: true
                    )
                    .onChange(of: nationalityList) { _ in
                        vm.nationality = nationalityList
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
        PreferenceNationalityView(
            vm: ProfileViewModel()
        )
    }
}
