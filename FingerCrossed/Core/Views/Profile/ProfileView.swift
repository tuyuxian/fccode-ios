//
//  ProfileView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct ProfileView: View {
    /// Banner
    @EnvironmentObject var bm: BannerManager
    /// Reference profile view model
    @StateObject var vm: ProfileViewModel
    
    init(preview: Bool = false) {
        _vm = StateObject(wrappedValue: ProfileViewModel(preview: preview))
    }
        
    var body: some View {
        ContainerWithLogoHeaderView(headerTitle: "Profile") {
            VStack(spacing: 0) {
                VStack(spacing: 18.75) {
                    Circle()
                        .fill(Color.surface2)
                        .frame(width: 122.5, height: 122.5, alignment: .center)
                        .overlay(
                            vm.state == .complete
                            ? Avatar(
                                avatarUrl: vm.user?.profilePictureUrl ?? "",
                                size: 121.5,
                                isActive: false
                            )
                            : nil
                        )
                    Text(vm.user?.username ?? "")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                }
                .zIndex(1)
                
                Box {
                    MenuList(
                        childViewList: [
                            ChildView(
                                label: "Basic Info",
                                subview:
                                    AnyView(
                                        BasicInfoView(
                                            vm: BasicInfoViewModel(user: vm.user ?? User.MockUser)
                                        )
                                        .environmentObject(bm)
                                    )
                            ),
                            ChildView(
                                label: "Preference",
                                subview: AnyView(
                                    PreferenceView()
                                        .environmentObject(bm)
                                )
                            ),
                            ChildView(
                                label: "Settings",
                                subview: AnyView(
                                    SettingsView()
                                        .environmentObject(vm)
                                        .environmentObject(bm)
                                )
                            ),
                            ChildView(
                                label: "Help & Support",
                                subview: AnyView(HelpSupportView())
                            )
                        ]
                    )
                    .padding(.top, 104) // 134 - 20 (ListRow) - 10 (first item)
                    .scrollDisabled(true)
                }
                .padding(.top, -104)
            }
        }
        .overlay {
            vm.state == .loading
            ? PageSpinner()
            : nil
        }
        .onChange(of: vm.state) { state in
            if state == .error {
                bm.pop(
                    title: vm.toastMessage,
                    type: .error
                )
                vm.state = .none
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            preview: true
        )
        .environmentObject(BannerManager())
    }
}
