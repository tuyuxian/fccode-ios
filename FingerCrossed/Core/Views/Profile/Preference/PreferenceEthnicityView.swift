//
//  PreferenceEthnicityView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceEthnicityView: View {
    /// View controller
    @Environment(\.presentationMode) var presentationMode
    /// Bannner
    @EnvironmentObject var bm: BannerManager
    /// Observed preference ethnicity view model
    @StateObject var vm = PreferenceEthnicityViewModel()
    /// Handler for  button on tap
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
            childTitle: "Ethnicity",
            showSaveButton: $vm.showSaveButton,
            isLoading: .constant(vm.state == .loading),
            action: buttonOnTap
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
                    .padding(.horizontal, 24)
                    .padding(.vertical, 30)
                    .onChange(of: vm.preference.ethnicities) { _ in
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

struct PreferenceEthnicityView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceEthnicityView()
            .environmentObject(BannerManager())
    }
}
