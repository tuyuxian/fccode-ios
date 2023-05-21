//
//  PreferenceView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceView: View {
    
    @ObservedObject var vm: ProfileViewModel

    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Profile",
            childTitle: "Preference",
            showSaveButton: false
        ) {
            Box {
                MenuList(
                    childViewList: [
                        ChildView(
                            label: "Sex Orientation",
                            subview: AnyView(PreferenceSexOrientationView(vm: vm))
                        ),
                        ChildView(
                            label: "Goal",
                            subview: AnyView(PreferenceGoalView(vm: vm))
                        ),
                        ChildView(
                            label: "Nationality",
                            subview: AnyView(PreferenceNationalityView(vm: vm))
                        ),
                        ChildView(
                            label: "Ethnicity",
                            subview: AnyView(PreferenceEthnicityView(vm: vm))
                        ),
                        ChildView(
                            label: "Age",
                            subview: AnyView(PreferenceAgeView(vm: vm))
                        ),
                        ChildView(
                            label: "Distance",
                            subview: AnyView(PreferenceDistanceView(vm: vm))
                        )
                    ]
                )
                
                Spacer()
            }
        }
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView(
            vm: ProfileViewModel()
        )
    }
}
