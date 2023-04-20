//
//  PreferenceView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceView: View {
    
    
    let preferenceOptions: [ChildView] = [
        ChildView(label: "Sex Orientation", view: AnyView(PreferenceSexOrientationView())),
        ChildView(label: "Goal", view: AnyView(PreferenceGoalView())),
        ChildView(label: "Nationality", view: AnyView(PreferenceSexOrientationView())), // TODO(Sam): change to nationality view
        ChildView(label: "Ethnicity", view: AnyView(PreferenceEthnicityView())),
        ChildView(label: "Distance", view: AnyView(PreferenceDistanceView())),
    ]
    

    var body: some View {
        ContainerWithHeaderView(parentTitle: "Profile", childTitle: "Preference", showSaveButton: false) {
            Box {
                MenuList(childViewList: preferenceOptions)
                Spacer()
            }
        }
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}
