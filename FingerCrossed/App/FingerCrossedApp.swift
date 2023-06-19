//
//  FingerCrossedApp.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/6/23.
//

import SwiftUI

@main
struct FingerCrossedApp: App {
    
    @StateObject var userManager: UserStateManager = UserStateManager()
    
    @StateObject var bannerManager: BannerManager = BannerManager()
    
    @StateObject var pageSpinnerManager: PageSpinnerManager = PageSpinnerManager()
    
    var body: some Scene {
        
        WindowGroup {
            ZStack {
                switch userManager.viewState {
                case .landing:
                    LandingView()
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.easeInOut) {
                                    userManager.viewState = userManager.isLogin ? .main : .onboarding
                                }
                            }
                        }
                        .preferredColorScheme(.light)
                case .onboarding:
                    EntryView(usm: userManager)
                        .preferredColorScheme(.light)
                        .environmentObject(bannerManager)
                        .environmentObject(pageSpinnerManager)
                case .main:
                    TabBar()
                        .environmentObject(userManager)
                        .environmentObject(bannerManager)
                }
                
                if bannerManager.isPresented {
                    BannerContent(bm: bannerManager)
                }
                
                if pageSpinnerManager.isPresented {
                    PageSpinner()
                }
            }
        }
        
    }
}
