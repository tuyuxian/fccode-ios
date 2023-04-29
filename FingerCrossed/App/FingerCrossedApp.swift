//
//  FingerCrossedApp.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/6/23.
//

import SwiftUI

@main
struct FingerCrossedApp: App {
    var body: some Scene {
        WindowGroup {
            TabBar()
                .environment(\.colorScheme, .light)
        }
    }
}
