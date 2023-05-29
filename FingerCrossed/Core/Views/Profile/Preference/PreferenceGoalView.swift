//
//  PreferenceGoalView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceGoalView: View {
    /// View controller
    @Environment(\.presentationMode) var presentationMode
    /// Global banner
    @EnvironmentObject var bm: BannerManager
    /// Observed profile view model
    @ObservedObject var vm: ProfileViewModel
    /// Flag to show up save button
    @State private var showSaveButton: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Goal option list
    let goalOptions: [String] = [
        "Not sure yet",
        "Serious relationship",
        "Casual relationship",
        "Situation relationship",
        "Meet new friends"
    ]
    /// Handler for save button on tap
    private func saveButtonOnTap() {
        // TODO(Sam): integrate graphql
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Goal",
            showSaveButton: $showSaveButton,
            isLoading: $isLoading,
            action: saveButtonOnTap
        ) {
            Box {
                VStack(spacing: 0) {
                    CheckBoxWithDivider(
                        items: goalOptions,
                        selectedIdList: Array(
                            vm.goal.map { $0.type.getString() }
                        ),
                        callback: { list in
                            vm.goal.removeAll()
                            for item in list {
                                vm.goal.append(
                                    Goal(
                                        type: GoalType.allCases.first(where: {
                                            $0.getString() == item
                                        }) ?? .GT0
                                    )
                                )
                            }
                        }
                    )
                    .padding(.horizontal, 24)
                    .padding(.vertical, 30)
                    .onChange(of: vm.goal) { _ in
                        showSaveButton = true
                    }
                    
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
