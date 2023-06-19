//
//  SettingsView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var user: UserViewModel
                    
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
                            if let userData = user.data {
                                SettingsAccountView(
                                    appleConnect: userData.appleConnect,
                                    googleConnect: userData.googleConnect
                                )
                                .environmentObject(user)
                            }
                        case .settingsResetPassword:
                            SettingsResetPasswordView()
                                .environmentObject(user)
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
            user: UserViewModel(preview: true)
        )
    }
}
