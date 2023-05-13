//
//  ProfileView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct ProfileView: View {
    
    @State var avatarUrl: String = "https://img.freepik.com/free-photo/pretty-smiling-joyfully-female-with-fair-hair-dressed-casually-looking-with-satisfaction_176420-15187.jpg?w=2000&t=st=1681172860~exp=1681173460~hmac=36c61c8ef9089e6e9875a89f7cc83463dcdcb9f79c052fab35a91224253a5d1e"
    @State var username: String = "Marine"
    
    let profileOptions: [ChildView] = [
        ChildView(label: "Basic Info", subview: AnyView(BasicInfoView())),
        ChildView(label: "Preference", subview: AnyView(PreferenceView())),
        ChildView(label: "Settings", subview: AnyView(SettingsView())),
        ChildView(label: "Help & Support", subview: AnyView(EmptyView())) // TODO(): add this in the future
    ]
    
    var body: some View {
        ContainerWithLogoHeaderView(headerTitle: "Profile") {
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
                                avatarUrl: avatarUrl,
                                size: 121.5,
                                isActive: false
                            )
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
