//
//  PreferenceAgeView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/25/23.
//

import SwiftUI

struct PreferenceAgeView: View {
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Age"
        ) {
            Box {
                VStack {
                    AgeSlider()
                }
                .padding(.horizontal, 24)
                Spacer()
            }
        }
    }
}

struct PreferenceAgeView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceAgeView()
    }
}
