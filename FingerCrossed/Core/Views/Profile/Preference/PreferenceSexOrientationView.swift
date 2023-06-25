//
//  PreferenceSexOrientationView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceSexOrientationView: View {
    /// View controller
    @Environment(\.dismiss) var dismiss
    /// Banner
    @EnvironmentObject var bm: BannerManager
    /// Init preference sex orientation view model
    @StateObject var vm = PreferenceSexOrientationViewModel()
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Sex Orientation",
            showSaveButton: $vm.showSaveButton,
            isLoading: .constant(vm.state == .loading),
            action: save
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
                    .onAppear {
                        vm.originalValue = vm.preference.sexOrientations
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 30)
                    .onChange(of: vm.preference.sexOrientations) { sexOrientations in
                        vm.checkEquality(sexOrientations: sexOrientations)
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

struct PreferenceSexOrientationView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceSexOrientationView()
            .environmentObject(BannerManager())
    }
}
