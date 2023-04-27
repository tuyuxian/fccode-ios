//
//  SwiftUIView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsView: View {
    let settingsOptions: [ChildView] = [
        ChildView(label: "Password", subview: AnyView(SettingsResetPasswordView())),
        ChildView(label: "Social Account", subview: AnyView(SettingsSocialAccountView())),
    ]
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Profile", childTitle: "Settings", showSaveButton: false) {
            Box {
                MenuList(childViewList: settingsOptions)
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
