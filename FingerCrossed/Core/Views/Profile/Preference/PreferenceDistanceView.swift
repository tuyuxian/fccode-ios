//
//  PreferenceDistanceView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceDistanceView: View {
    /// Observed Profile view model
    @ObservedObject var vm: ProfileViewModel
    
    let distanceOptions: [String] = [
        "25 miles",
        "50 miles",
        "75 miles",
        "100 miles",
        "Any"
    ]
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Distance",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            Box {
                RadioButtonWithDivider(callback: { selected in
                    vm.distance = selected
                }, items: distanceOptions)
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
