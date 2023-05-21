//
//  CameraPermissionManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/21/23.
//

import Foundation
import AVFoundation

final class CameraPermissionManager {
    
    let alertTitle: String = "Allow camera access in device settings"
    
    let alertMessage: String = "Finger Crossed uses your device's camera so you can take photos"
    
    public var permissionStatus: PermissionStatus {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
    
    public func requestPermission(
        completion: @escaping (Bool, Error?) -> Void
    ) {
        AVCaptureDevice.requestAccess(
            for: AVMediaType.video,
            completionHandler: { authStatus in
                DispatchQueue.main.async {
                    completion(authStatus, nil)
                }
            }
        )
    }
}
