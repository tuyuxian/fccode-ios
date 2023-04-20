//
//  ProfileView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct ProfileView: View {
    
    @State var avatarUrl: String = "https://i.pravatar.cc/150?img=59"
    @State var username: String = "Marine"
    
    let profileOptions: [ChildView] = [
        ChildView(label: "Basic Info", view: AnyView(BasicInfoNameView())), // TODO(Sam): connect with basic info view
        ChildView(label: "Plan", view: AnyView(EmptyView())), // TODO(): add this in the future
        ChildView(label: "Preference", view: AnyView(PreferenceView())),
        ChildView(label: "Settings", view: AnyView(SettingsView())),
        ChildView(label: "Help & Support", view: AnyView(EmptyView())), // TODO(): add this in the future
    ]
    
    var body: some View {
        ContainerWithLogoHeaderView(headerTitle: "Profile") {
            VStack(spacing: 0) {
                VStack(spacing: 18.75) {
                    Circle()
                        .fill(Color.surface2)
                        .frame(width: 122.5, height: 122.5, alignment: .center)  // TODO(Sam): check stroke width
                        .overlay(
                            Avatar(avatarUrl: avatarUrl,size: 121.5, isActive: false)
                        )
                    Text(username)
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                }
                .zIndex(1)
                Box {
                    MenuList(childViewList: profileOptions)
                        .padding(.top, 104) // 134 - 20 (ListRow) - 10 (first item's padding)
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
