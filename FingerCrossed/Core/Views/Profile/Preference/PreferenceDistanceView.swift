//
//  PreferenceDistanceView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct PreferenceDistanceView: View {
    /// View controller
    @Environment(\.dismiss) var dismiss
    /// Banner
    @EnvironmentObject var bm: BannerManager
    /// Init preference distance view model
    @StateObject var vm = PreferenceDistanceViewModel()

    init() {
        print("[Preference Distance] view init")
    }
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Distance",
            showSaveButton: $vm.showSaveButton,
            isLoading: .constant(vm.state == .loading),
            action: save
        ) {
            Box {
                RadioButtonWithDivider(
                    items: vm.distanceOptions,
                    selectedId: vm.getStringFromDistance(vm.preference.distance),
                    callback: { selected in
                        vm.preference.distance = vm.getIntFromDistanceOption(selected)
                    }
                )
                .onAppear {
                    vm.originalValue = vm.getStringFromDistance(vm.preference.distance)
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 24)
                .onChange(of: vm.preference.distance) { distance in
                    vm.showSaveButton = !(vm.getStringFromDistance(distance) == vm.originalValue)
                }
                
                Spacer()
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

struct PreferenceDistanceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceDistanceView()
            .environmentObject(BannerManager())
    }
}
