//
//  FingerCrossedApp.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/6/23.
//

import SwiftUI

@main
struct FingerCrossedApp: App {
    
    @StateObject var global: GlobalViewModel = GlobalViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            switch global.viewState {
            case .landing:
                LandingView()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeInOut) {
                                global.viewState = global.isLogin ? .main : .onboarding
                            }
                        }
                    }
                    .preferredColorScheme(.light)
            case .onboarding:
                EntryView(global: global)
                    .preferredColorScheme(.light)
            case .main:
                TabBar()
                    .preferredColorScheme(.light)
            }
        }
        
    }
}
