//
//  PreferenceView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceView: View {
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Profile",
            childTitle: "Preference",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            Box {
                FCList<PreferenceDestination>(
                    destinationViewList: [
                        DestinationView(
                            label: "Sex Orientation",
                            subview: .preferenceSexOrientation
                        ),
                        DestinationView(
                            label: "Goal",
                            subview: .preferenceGoal
                        ),
                        DestinationView(
                            label: "Nationality",
                            subview: .preferenceNationality
                        ),
                        DestinationView(
                            label: "Ethnicity",
                            subview: .preferenceEthnicity
                        ),
                        DestinationView(
                            label: "Age",
                            subview: .preferenceAge
                        ),
                        DestinationView(
                            label: "Distance",
                            subview: .preferenceDistance
                        )
                    ]
                )
                .scrollDisabled(true)
                
                Spacer()
            }
            .navigationDestination(for: PreferenceDestination.self) { destination in
                Group {
                    switch destination {
                    case .preferenceAge:
                        PreferenceAgeView()
                    case .preferenceGoal:
                        PreferenceGoalView()
                    case .preferenceDistance:
                        PreferenceDistanceView()
                    case .preferenceEthnicity:
                        PreferenceEthnicityView()
                    case .preferenceNationality:
                        PreferenceNationalityView()
                    case .preferenceSexOrientation:
                        PreferenceSexOrientationView()
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}
