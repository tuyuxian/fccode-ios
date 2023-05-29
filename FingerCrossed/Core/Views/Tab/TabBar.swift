//
//  TabBar.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct TabBar: View {
    
    @StateObject var vm = TabViewModel()
    
    @ObservedObject var userState: UserStateViewModel
    
    let notificationPermissionManager = NotificationPermissionManager()
    
    init(
        userState: UserStateViewModel
    ) {
        UITabBar.appearance().isHidden = true
        self.userState = userState
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $vm.currentTab) {
                TextingView()
                    .tag(TabState.texting)
                PairingView()
                    .tag(TabState.pairing)
                ProfileView()
                    .tag(TabState.profile)
                    .environmentObject(userState)
            }
            
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
        .environmentObject(vm)
        .onAppear {
            notificationPermissionManager.requestPermission { _, _ in }
            print(userState.token ?? "failed to get token")
        }
        .preferredColorScheme(vm.currentTab == .pairing ? .dark : .light)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(
            userState: UserStateViewModel()
        )
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

enum TabState {
    case texting
    case pairing
    case profile
    
    public func getTitle() -> String {
        switch self {
        case .texting:
            return "Chat"
        case .pairing:
            return "Pairing"
        case .profile:
            return "Profile"
        }
    }
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
    
    @Published var currentTab: TabState = .pairing
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
