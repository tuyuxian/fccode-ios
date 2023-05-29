//
//  PreferenceAgeView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/25/23.
//

import SwiftUI

struct PreferenceAgeView: View {
    /// Observed profile view model
    @ObservedObject var vm: ProfileViewModel
    /// Flag to show up save button
    @State private var showSaveButton: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Age",
            showSaveButton: $showSaveButton,
            isLoading: $isLoading
        ) {
            Box {
                VStack {
                    AgeSlider(
                        ageFrom: $vm.ageFrom,
                        ageTo: $vm.ageTo
                    )
                }
                .onTapGesture {
                    print(vm.ageFrom)
                    print(vm.ageTo)
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}

struct PreferenceAgeView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceAgeView(
            vm: ProfileViewModel()
        )
    }
}
