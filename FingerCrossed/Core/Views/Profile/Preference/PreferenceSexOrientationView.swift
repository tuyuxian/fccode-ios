//
//  PreferenceSexOrientationView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceSexOrientationView: View {
    /// View controller
    @Environment(\.presentationMode) var presentationMode
    /// Banner
    @EnvironmentObject var bm: BannerManager
    /// Observed preference sex orientation view model
    @StateObject var vm = PreferenceSexOrientationViewModel()
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
            childTitle: "Sex Orientation",
            showSaveButton: $vm.showSaveButton,
            isLoading: .constant(vm.state == .loading),
            action: buttonOnTap
        ) {
            Box {
                VStack(spacing: 0) {
                    CheckBoxWithDivider(
                        items: vm.sexOrientationOptions,
                        selectedIdList: Array(
                            vm.preference.sexOrientations.map { $0.type.getString() }
                        ),
                        callback: { list in
                            vm.preference.sexOrientations.removeAll()
                            for item in list {
                                vm.preference.sexOrientations.append(
                                    SexOrientation(
                                        type: vm.getType(item)
                                    )
                                )
                            }
                        }
                    )
                    .padding(.horizontal, 24)
                    .padding(.vertical, 30)
                    .onChange(of: vm.preference.sexOrientations) { _ in
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

struct PreferenceSexOrientationView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceSexOrientationView()
            .environmentObject(BannerManager())
    }
}
