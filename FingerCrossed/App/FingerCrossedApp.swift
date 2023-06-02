//
//  FingerCrossedApp.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/6/23.
//

import SwiftUI

@main
struct FingerCrossedApp: App {
    
    @StateObject var userState: UserStateViewModel = UserStateViewModel()
    
    @StateObject var bannerManager: BannerManager = BannerManager()
    
    @StateObject var pageSpinnerManager: PageSpinnerManager = PageSpinnerManager()
    
    var body: some Scene {
        
        WindowGroup {
            ZStack {
                switch userState.viewState {
                case .landing:
                    LandingView()
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.easeInOut) {
                                    userState.viewState = userState.isLogin ? .main : .onboarding
                                }
                            }
                        }
                        .preferredColorScheme(.light)
                case .onboarding:
                    EntryView(userState: userState)
                        .preferredColorScheme(.light)
                        .environmentObject(bannerManager)
                        .environmentObject(pageSpinnerManager)
                case .main:
                    TabBar(userState: userState)
                        .environmentObject(userState)
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
