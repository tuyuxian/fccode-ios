//
//  ProfileView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm: ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        ContainerWithLogoHeaderView(
            headerTitle: "Profile"
        ) {
            VStack(spacing: 0) {
                VStack(spacing: 18.75) {
                    Circle()
                        .fill(Color.surface2)
                        .frame(
                            width: 122.5,
                            height: 122.5,
                            alignment: .center
                        )
                        .overlay(
                            Avatar(
                                avatarUrl: vm.user.avatarURL!,
                                size: 121.5,
                                isActive: false
                            )
                        )
                    Text(vm.user.username!)
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                }
                .zIndex(1)
                Box {
                    MenuList(
                        childViewList: [
                            ChildView(
                                label: "Basic Info",
                                subview: AnyView(BasicInfoView())
                            ),
                            ChildView(
                                label: "Preference",
                                subview: AnyView(PreferenceView(vm: vm))
                            ),
                            ChildView(
                                label: "Settings",
                                subview: AnyView(SettingsView(vm: vm))
                            ),
                            // TODO(Lawrence): add this in the future
                            ChildView(
                                label: "Help & Support",
                                subview: AnyView(EmptyView())
                            )
                        ]
                    )
                    .padding(.top, 104) // 134 - 20 (ListRow) - 10 (first item)
                }
                .padding(.top, -104)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
