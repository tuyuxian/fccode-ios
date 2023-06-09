//
//  PreferenceNationalityView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/11/23.
//

import SwiftUI

struct PreferenceNationalityView: View {
    /// View controller
    @Environment(\.presentationMode) var presentationMode
    /// Banner
    @EnvironmentObject var bm: BannerManager
    /// Observed profile view model
    @StateObject var vm = PreferenceNationalityViewModel()
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
            childTitle: "Nationality",
            showSaveButton: $vm.showSaveButton,
            isLoading: .constant(vm.state == .loading),
            action: buttonOnTap
        ) {
            Box {
                VStack {
                    Text("Pick your favorite top three or leave it blank to connect people worldwide!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontTemplate(.h4Medium)
                        .foregroundColor(Color.textHelper)
                        .padding(.bottom, 30)

                    NationalityPicker(
                        nationalityList: $vm.preference.nationalities,
                        isPreference: true
                    )
                    .onChange(of: vm.preference.nationalities) { _ in
                        vm.showSaveButton = true
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 24)
                
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

struct PreferenceNationalityView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceNationalityView()
            .environmentObject(BannerManager())
    }
}
