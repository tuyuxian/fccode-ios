//
//  PreferenceAgeView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/25/23.
//

import SwiftUI

struct PreferenceAgeView: View {
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Preference", childTitle: "Age") {
            Box {
                VStack {
                    AgeSlider()
                }
                .padding(EdgeInsets(top: 44, leading: 24, bottom: 0, trailing: 24))
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
