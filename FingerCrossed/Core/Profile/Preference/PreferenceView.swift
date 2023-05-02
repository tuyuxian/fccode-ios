//
//  PreferenceView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceView: View {
    
    
    let preferenceOptions: [ChildView] = [
<<<<<<< HEAD
        ChildView(label: "Sex Orientation", view: AnyView(PreferenceSexOrientationView())),
        ChildView(label: "Goal", view: AnyView(PreferenceGoalView())),
        ChildView(label: "Nationality", view: AnyView(PreferenceNationalityView())), // TODO(Sam): change to nationality view
        ChildView(label: "Ethnicity", view: AnyView(PreferenceEthnicityView())),
        ChildView(label: "Distance", view: AnyView(PreferenceDistanceView())),
=======
        ChildView(label: "Sex Orientation", subview: AnyView(PreferenceSexOrientationView())),
        ChildView(label: "Goal", subview: AnyView(PreferenceGoalView())),
        ChildView(label: "Nationality", subview: AnyView(PreferenceSexOrientationView())), // TODO(Sam): change to nationality view
        ChildView(label: "Ethnicity", subview: AnyView(PreferenceEthnicityView())),
        ChildView(label: "Age", subview: AnyView(PreferenceAgeView())),
        ChildView(label: "Distance", subview: AnyView(PreferenceDistanceView())),
>>>>>>> release
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
