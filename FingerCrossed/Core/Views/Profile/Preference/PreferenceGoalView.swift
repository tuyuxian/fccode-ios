//
//  PreferenceGoalView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceGoalView: View {
    /// Observed Profile view model
    @ObservedObject var vm: ProfileViewModel
    
    let goalOptions: [String] = [
        "Serious relationship",
        "Casual relationship",
        "Situation relationship",
        "Meet new friends",
        "Boost self-esteem"
    ]
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Goal",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            Box {
                VStack(spacing: 0) {
                    CheckBoxWithDivider(items: goalOptions) { list in
                        vm.goal.removeAll()
                        for item in list {
                            vm.goal.append(item)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 30)
                    
                    Spacer()
                }
            }
        }
    }
}

struct PreferenceGoalView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceGoalView(vm: ProfileViewModel())
    }
}
