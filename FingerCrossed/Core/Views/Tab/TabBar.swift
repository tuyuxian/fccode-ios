//
//  TabBar.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct TabBar: View {
    
    @StateObject var vm = TabViewModel()
    
    @EnvironmentObject var usm: UserStateManager
    
    @EnvironmentObject var bm: BannerManager
    
    let notificationPermissionManager = NotificationPermissionManager()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $vm.currentTab) {
                TextingView()
                    .tag(TabState.texting)
//                PairingView()
//                    .tag(TabState.pairing)
                ProfileView()
                    .tag(TabState.profile)
                    .environmentObject(bm)
                    .environmentObject(usm)
            }
            .preferredColorScheme(vm.currentTab == .pairing ? .dark : .light)
            
            vm.showTab
            ? HStack(spacing: 0) {
                ForEach(
                    ["Chat", "Pairing", "Profile"],
                    id: \.self
                ) { icon in
                    TabBarButton(
                        icon: icon,
                        currentTab: $vm.currentTab
                    )
                }
            }
            .padding(.top, 10)
            .overlay(Divider().overlay(Color.surface2), alignment: .top)
            .background(vm.currentTab == .pairing ? Color.surface4 : Color.surface3)
            .transition(.customTransition)
            : nil
            
        }
        .ignoresSafeArea(.keyboard)
        .environmentObject(vm)
        .onAppear {
            notificationPermissionManager.requestPermission { _, _ in }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .environmentObject(UserStateManager())
            .environmentObject(BannerManager())
    }
}

struct TabBarButton: View {
    var icon: String
    @Binding var currentTab: TabState
    var body: some View {
        Button {
            currentTab = TabViewModel.getTabState(icon)
        } label: {
            ZStack {
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
            }
            .foregroundColor(
                currentTab == TabViewModel.getTabState(icon)
                ? Color.yellow100
                : Color.surface2
            )
            .frame(maxWidth: .infinity)
        }
    }
}

enum TabState: String {
    case texting = "Chat"
    case pairing = "Pairing"
    case profile = "Profile"
}

class TabViewModel: ObservableObject {
    
    public class func getTabState(_ from: String) -> TabState {
        switch from {
        case "Chat":
            return .texting
        case "Profile":
            return .profile
        default:
            return .pairing
        }
    }
    
    @Published var currentTab: TabState = .profile
    @Published var showTab: Bool = true
}

extension AnyTransition {
    static var customTransition: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .bottom)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
