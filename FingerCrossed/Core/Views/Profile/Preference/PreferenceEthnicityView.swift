//
//  PreferenceEthnicityView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceEthnicityView: View {
    /// View controller
    @Environment(\.dismiss) var dismiss
    /// Banner
    @EnvironmentObject var bm: BannerManager
    /// Init preference ethnicity view model
    @StateObject var vm = PreferenceEthnicityViewModel()

    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Ethnicity",
            showSaveButton: $vm.showSaveButton,
            isLoading: .constant(vm.state == .loading),
            action: save
        ) {
            Box {
                VStack(spacing: 0) {
                    CheckBoxWithDivider(
                        items: vm.ethnicityOptions,
                        selectedIdList: Array(
                            vm.preference.ethnicities.count == 0
                            ? ["Everyone"]
                            : vm.preference.ethnicities.map { $0.type.getString() }
                        ),
                        callback: { list in
                            vm.preference.ethnicities.removeAll()
                            for item in list {
                                if let et = vm.getType(item) {
                                    vm.preference.ethnicities.append(
                                        Ethnicity(type: et)
                                    )
                                }
                            }
                        }
                    )
                    .onAppear {
                        vm.originalValue = vm.preference.ethnicities
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 30)
                    .onChange(of: vm.preference.ethnicities) { ethnicities in
                        vm.checkEquality(ethnicities: ethnicities)
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

struct PreferenceEthnicityView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceEthnicityView()
            .environmentObject(BannerManager())
    }
}
