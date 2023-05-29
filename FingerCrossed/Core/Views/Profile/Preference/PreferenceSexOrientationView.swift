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
    /// Global banner
    @EnvironmentObject var bm: BannerManager
    /// Observed profile view model
    @ObservedObject var vm: ProfileViewModel
    /// Flag to show up save button
    @State private var showSaveButton: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Sex orientation option list
    let sexOrientationOptions: [String] = [
        "Open to all",
        "Heterosexuality",
        "Bisexuality",
        "Homosexuality"
    ]
    /// Handler for save button on tap
    private func saveButtonOnTap() {
        // TODO(Sam): integrate graphql
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Preference",
            childTitle: "Sex Orientation",
            showSaveButton: $showSaveButton,
            isLoading: $isLoading,
            action: saveButtonOnTap
        ) {
            Box {
                VStack(spacing: 0) {
                    CheckBoxWithDivider(
                        items: sexOrientationOptions,
                        selectedIdList: Array(
                            vm.sexOrientation.map { $0.type.getString() }
                        ),
                        callback: { list in
                            vm.sexOrientation.removeAll()
                            for item in list {
                                vm.sexOrientation.append(
                                    SexOrientation(
                                        type: SexOrientationType.allCases.first(where: {
                                            $0.getString() == item
                                        }) ?? .SO1
                                    )
                                )
                            }
                        }
                    )
                    .padding(.horizontal, 24)
                    .padding(.vertical, 30)
                    .onChange(of: vm.sexOrientation) { _ in
                        showSaveButton = true
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct PreferenceSexOrientationView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceSexOrientationView(
            vm: ProfileViewModel()
        )
    }
}
