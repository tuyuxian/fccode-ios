//
//  PreferenceGoalView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceGoalView: View {
    
    let goalOptions:[String] = [
        "Serious relationship",
        "Casual relationship",
        "Situation relationship",
        "Meet new friends",
        "Boost self-esteem",
    ]
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Preference", childTitle: "Goal") {
            Box {
                VStack(spacing: 0) {
                    ForEach(Array(goalOptions.enumerated()), id: \.element.self) { index, goal in
                        HStack {
                            CheckboxButton(label: goal) // TODO(Sam): add click state
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24))
                        
                        
                        index != goalOptions.count - 1
                        ? Divider().foregroundColor(Color.surface2) // TODO(Sam): use surface3
                            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                        : nil
                        
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                Spacer()
                TabBar()
            }
        }
    }
}

struct PreferenceGoalView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceGoalView()
    }
}
