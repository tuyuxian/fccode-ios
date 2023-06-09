//
//  PreferenceView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceView: View {
    /// Banner
    @EnvironmentObject var bm: BannerManager

    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Profile",
            childTitle: "Preference",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            Box {
                MenuList(
                    childViewList: [
                        ChildView(
                            label: "Sex Orientation",
                            subview: AnyView(
                                PreferenceSexOrientationView()
                                    .environmentObject(bm)
                            )
                        ),
                        ChildView(
                            label: "Goal",
                            subview: AnyView(
                                PreferenceGoalView()
                                    .environmentObject(bm)
                            )
                        ),
                        ChildView(
                            label: "Nationality",
                            subview: AnyView(
                                PreferenceNationalityView()
                                    .environmentObject(bm)
                            )
                        ),
                        ChildView(
                            label: "Ethnicity",
                            subview: AnyView(
                                PreferenceEthnicityView()
                                    .environmentObject(bm)
                            )
                        ),
                        ChildView(
                            label: "Age",
                            subview: AnyView(
                                PreferenceAgeView()
                                    .environmentObject(bm)
                            )
                        ),
                        ChildView(
                            label: "Distance",
                            subview: AnyView(
                                PreferenceDistanceView()
                                    .environmentObject(bm)
                            )
                        )
                    ]
                )
                .scrollDisabled(true)
                
                Spacer()
            }
        }
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
            .environmentObject(BannerManager())
    }
}
