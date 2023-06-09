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
    /// Observed preference goal view model
    @StateObject var vm = PreferenceGoalViewModel()
    /// Handler for save button on tap
    private func buttonOnTap() {
        Task {
            await vm.buttonOnTap()
            guard vm.state == .complete else { return }
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Goal",
            showSaveButton: $vm.showSaveButton,
            isLoading: .constant(vm.state == .loading),
            action: buttonOnTap
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
                    .padding(.horizontal, 24)
                    .padding(.vertical, 30)
                    .onChange(of: vm.preference.goals) { _ in
                        vm.showSaveButton = true
                    }
                    
                    Spacer()
                }
            }
            .onChange(of: vm.state) { state in
                if state == .error {
                    bm.pop(
                        title: vm.errorMessage,
                        type: .error
                    )
                    vm.state = .none
                }
            }
        }
    }
}

struct PreferenceGoalView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceGoalView()
            .environmentObject(BannerManager())
    }
}
