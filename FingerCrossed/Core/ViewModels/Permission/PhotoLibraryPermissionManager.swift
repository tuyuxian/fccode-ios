//
//  PhotoLibraryPermissionManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/21/23.
//

import Foundation
import Photos

final class PhotoLibraryPermissionManager {
    
    let alertTitle: String = "Allow photos access in device settings"
    
    // swiftlint: disable line_length
    let alertMessage: String = "Finger Crossed uses your device's photo library so you can share photos."
    // swiftlint: enable line_length
    
    public var permissionStatus: PermissionStatus {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        case .limited:
            return .limited
        default:
            return .denied
        }
    }
    
    public func requestPermission(
        completion: @escaping (Bool, Error?
        ) -> Void) {
        PHPhotoLibrary.requestAuthorization { authStatus in
            switch authStatus {
            case .authorized:
                completion(true, nil)
            case .limited:
                completion(true, nil)
            default:
                completion(false, nil)
            }
        }
    }
}
