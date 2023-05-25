//
//  NotificationPermissionManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/22/23.
//

import Foundation
import UserNotifications
import UIKit

final class NotificationPermissionManager {
    var notificationManager = UNUserNotificationCenter.current()

    public func requestPermission(
        completion: @escaping (Bool, Error?) -> Void
    ) {
        notificationManager.requestAuthorization(
            options: [.badge, .alert, .sound]
        ) { granted, error in
            completion(granted, error)
        }
       
        UIApplication.shared.registerForRemoteNotifications()
    }
}
