//
//  SettingsView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var vm: ProfileViewModel
        
    @EnvironmentObject var bm: BannerManager
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Profile",
            childTitle: "Settings",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            Box {
                MenuList(
                    childViewList: [
                        ChildView(
                            label: "Account",
                            subview: AnyView(
                                SettingsAccountView(
                                    appleConnect: vm.user?.appleConnect ?? false,
                                    googleConnect: vm.user?.googleConnect ?? false
                                )
                                .environmentObject(bm)
                            )
                        ),
                        ChildView(
                            label: "Password",
                            subview: AnyView(
                                SettingsResetPasswordView(
                                    hasPassword: vm.user?.password != "" && vm.user?.password != nil
                                )
                                .environmentObject(bm)
                            )
                        )
                    ]
                )
                .scrollDisabled(true)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ProfileViewModel())
            .environmentObject(BannerManager())
    }
}
