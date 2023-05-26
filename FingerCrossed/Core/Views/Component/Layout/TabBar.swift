//
//  TabBar.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct TabBar: View {
    
    @State var currentTab = "Pairing"
    @StateObject var vm = TabViewModel()
    
    let notificationPermissionManager = NotificationPermissionManager()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                TextingView()
                    .tag("Chat")
                PairingView()
                    .tag("Pairing")
                    .preferredColorScheme(.dark)
                ProfileView()
                    .tag("Profile")
            }
            
            vm.showTab
            ? HStack(spacing: 0) {
                    ForEach(
                        ["Chat", "Pairing", "Profile"],
                        id: \.self
                    ) { icon in
                        TabBarButton(
                            icon: icon,
                            currentTab: $currentTab
                        )
                    }
                }
                .padding(.top, 10)
                .overlay(Divider().overlay(Color.surface2), alignment: .top)
                .background(currentTab == "Pairing" ? Color.surface4 : Color.surface3)
                .transition(.customTransition)
            : nil
            
        }
        .environmentObject(vm)
        .onAppear {
            notificationPermissionManager.requestPermission { _, _ in}
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

struct TabBarButton: View {
    var icon: String
    @Binding var currentTab: String
    var body: some View {
        Button {
            currentTab = icon
        } label: {
            ZStack {
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
            }
            .foregroundColor(currentTab == icon ? Color.yellow100 : Color.surface2)
            .frame(maxWidth: .infinity)
        }
    }
}

class TabViewModel: ObservableObject {
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
