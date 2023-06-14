//
//  SettingsView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var vm: ProfileViewModel
                
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Profile",
            childTitle: "Settings",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            Box {
                FCList<SettingsDestination>(
                    destinationViewList: [
                        DestinationView(
                            label: "Account",
                            subview: .settingsAccount
                        ),
                        DestinationView(
                            label: "Password",
                            subview: .settingsResetPassword
                        )
                    ]
                )
                .scrollDisabled(true)
                .navigationDestination(for: SettingsDestination.self) { destination in
                    Group {
                        switch destination {
                        case .settingsAccount:
                            SettingsAccountView(
                                appleConnect: vm.user?.appleConnect ?? false,
                                googleConnect: vm.user?.googleConnect ?? false
                            )
                        case .settingsResetPassword:
                            SettingsResetPasswordView(
                                hasPassword: vm.user?.password != "" && vm.user?.password != nil
                            )
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            vm: ProfileViewModel()
        )
    }
}
