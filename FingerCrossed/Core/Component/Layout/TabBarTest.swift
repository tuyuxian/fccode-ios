//
//  TabBarTest.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/17/23.
//

import SwiftUI

struct TabBarTest: View {

    @State private var selectedTabIndex = 0

    init() {
        let bg = UITabBarAppearance()
        bg.configureWithDefaultBackground()
        bg.stackedLayoutAppearance.normal.iconColor = UIColor(Color.surface2)
        bg.backgroundColor = UIColor(Color.background)
        UITabBar.appearance().standardAppearance = bg
        UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
    }
    

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTabIndex) {
                TextingView()
                    .tabItem {
                        Image("Chat")
                            .renderingMode(.template)
                    }
                    .tag(0)
                ProfileView()
                    .tabItem {
                        Image("Pairing")
                            .renderingMode(.template)
                    }
                    .tag(1)
                ProfileView()
                    .tabItem {
                        Image("Profile")
                            .renderingMode(.template)
                    }
                    .tag(2)
            }
            .tint(Color.yellow100)
        }
    }
}

struct TabBarTest_Previews: PreviewProvider {
    static var previews: some View {
        TabBarTest()
    }
}
