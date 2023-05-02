//
//  TabBar.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct TabBar: View {
    
    @State var currentTab = "Profile"
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                TextingView()
                    .tag("Chat")
                ProfileView()
                    .tag("Pairing")
                ProfileView()
                    .tag("Profile")
            }
            HStack(spacing: 0) {
                ForEach(["Chat", "Pairing", "Profile"], id: \.self) { icon in TabBarButton(icon: icon, currentTab: $currentTab)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .overlay(Divider().foregroundColor(Color.surface2), alignment: .top)
            .background(currentTab == "Pairing" ? Color.surface4 : Color.surface3)
        }
        .ignoresSafeArea(.keyboard)
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
            withAnimation {
                currentTab = icon
            }
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
