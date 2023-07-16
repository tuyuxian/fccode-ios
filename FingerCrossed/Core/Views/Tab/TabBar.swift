//
//  TabBar.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct TabBar: View {
    
    @StateObject var vm = ViewModel()
    
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
                    .environmentObject(vm)
                    .tag(TabState.chat)
                PairingView()
                    .tag(TabState.pairing)
                ProfileView()
                    .tag(TabState.profile)
            }
            .preferredColorScheme(vm.currentTab == .pairing ? .dark : .light)
            
            vm.showTab
            ? HStack(spacing: 0) {
                ForEach(
                    [FCIcon.chat, FCIcon.pairing, FCIcon.profile],
                    id: \.self
                ) { icon in
                    TabButton(
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

extension TabBar {
    
    struct TabButton: View {
        
        let icon: FCIcon
        
        @Binding var currentTab: TabState
        
        var body: some View {
            Button {
                currentTab = getTab(icon)
            } label: {
                ZStack {
                    icon.resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                }
                .foregroundColor(
                    currentTab == getTab(icon)
                    ? Color.yellow100
                    : Color.surface2
                )
                .frame(maxWidth: .infinity)
            }
        }
        
        private func getTab(
            _ from: FCIcon
        ) -> TabBar.TabState {
            switch from {
            case .chat:
                return .chat
            case .pairing:
                return .pairing
            case .profile:
                return .profile
            default:
                return .pairing
            }
        }
    }
    
}

extension TabBar {
    
    enum TabState {
        case chat
        case pairing
        case profile
    }
    
    class ViewModel: ObservableObject {
        @Published var currentTab: TabState = .pairing
        @Published var showTab: Bool = true
    }
    
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
