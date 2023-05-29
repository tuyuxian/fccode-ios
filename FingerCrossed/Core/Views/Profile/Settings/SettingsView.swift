//
//  SwiftUIView.swift
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
                MenuList(
                    childViewList: [
                        ChildView(
                            label: "Password",
                            subview: AnyView(SettingsResetPasswordView(vm: vm))
                        ),
                        ChildView(
                            label: "Account",
                            subview: AnyView(SettingsAccountView(vm: vm))
                        )
                    ]
                )
                .scrollDisabled(true)
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            vm: ProfileViewModel()
        )
    }
}
