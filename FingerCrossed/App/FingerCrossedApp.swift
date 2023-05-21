//
//  FingerCrossedApp.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/6/23.
//

import SwiftUI

@main
struct FingerCrossedApp: App {
    @State var loggedIn: Bool = false
    var body: some Scene {
        
        WindowGroup {
            if loggedIn {
                ProfileView()
                    .preferredColorScheme(.light)
            } else {
                LandingView()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeInOut) {
                                loggedIn.toggle()
                            }
                        }
                    }
            }
        }
        
    }
}
