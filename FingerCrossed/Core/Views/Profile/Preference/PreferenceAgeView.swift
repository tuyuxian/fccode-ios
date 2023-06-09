//
//  PreferenceAgeView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/25/23.
//

import SwiftUI

struct PreferenceAgeView: View {
    /// View controller
    @Environment(\.presentationMode) var presentationMode
    /// Bannner
    @EnvironmentObject var bm: BannerManager
    /// Observed preference age view model
    @StateObject var vm = PreferenceAgeViewModel()
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
            childTitle: "Age",
            showSaveButton: $vm.showSaveButton,
            isLoading: .constant(vm.state == .loading),
            action: buttonOnTap
        ) {
            Box {
                VStack {
                    AgeSlider(
                        ageFrom: $vm.preference.ageRange.from,
                        ageTo: $vm.preference.ageRange.to
                    )
                }
                .padding(.horizontal, 24)
                .onChange(of: vm.preference.ageRange.from) { _ in
                    vm.showSaveButton = true
                }
                .onChange(of: vm.preference.ageRange.to) { _ in
                    vm.showSaveButton = true
                }
                
                Spacer()
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

struct PreferenceAgeView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceAgeView()
            .environmentObject(BannerManager())
    }
}
