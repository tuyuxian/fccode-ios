//
//  AppDelegate.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/2/23.
//

import UIKit
import SwiftUI
import FacebookCore

class AppDelegate: NSObject, UIApplicationDelegate {
    /// Force phone to use portrait mode
    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        return UIDevice.current.userInterfaceIdiom == .phone ? .portrait : .all
    }
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        /// Set the appearance for the drag indicator and keyboard
        UITextField.appearance().keyboardAppearance = .light
        UIScrollView.appearance().indicatorStyle = .default
        
        return true
    }
}
