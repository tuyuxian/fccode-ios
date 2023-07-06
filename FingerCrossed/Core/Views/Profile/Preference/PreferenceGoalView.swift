//
//  PreferenceGoalView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceGoalView: View {
    /// View controller
    @Environment(\.dismiss) var dismiss
    /// Banner
    @EnvironmentObject var bm: BannerManager
    /// Init preference goal view model
    @StateObject var vm = PreferenceGoalViewModel()
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Goal",
            showSaveButton: $vm.showSaveButton,
            isLoading: .constant(vm.state == .loading),
            action: save
        ) {
            Box {
                VStack(spacing: 0) {
                    CheckBoxWithDivider(
                        items: vm.goalOptions,
                        selectedIdList: Array(
                            vm.preference.goals.count == 0
                            ? ["Not sure yet"]
                            : vm.preference.goals.map { $0.type.getString() }
                        ),
                        callback: { list in
                            vm.preference.goals.removeAll()
                            for item in list {
                                if let gt = vm.getType(item) {
                                    vm.preference.goals.append(
                                        Goal(type: gt)
                                    )
                                }
                            }
                        }
                    )
                    .onAppear {
                        vm.originalValue = vm.preference.goals
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 30)
                    .onChange(of: vm.preference.goals) { goals in
                        vm.checkEquality(goals: goals)
                    }
                    
                    Spacer()
                }
            }
            .onChange(of: vm.state) { state in
                if state == .error {
                    bm.pop(
                        title: vm.toastMessage,
                        type: vm.toastType
                    )
                    vm.state = .none
                }
            }
        }
    }
    
    private func save() {
        Task {
            await vm.save()
            guard vm.state == .complete else { return }
            dismiss()
        }
    }
}

struct PreferenceGoalView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceGoalView()
            .environmentObject(BannerManager())
    }
}
