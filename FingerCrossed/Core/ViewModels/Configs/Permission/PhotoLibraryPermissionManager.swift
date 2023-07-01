//
//  PhotoLibraryPermissionManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/21/23.
//

import PhotosUI

final class PhotoLibraryPermissionManager {
    
    let alertTitle: String = "Allow photos access in device settings"
    
    let alertMessage: String = "Finger Crossed uses your device's photo library so you can share photos."
    
    typealias PhotoLibraryAuthStatus = (isAllowed: Bool, isLimited: Bool)
    
    public var permissionStatus: PermissionStatus {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
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
        completion: @escaping (PhotoLibraryAuthStatus) -> Void
    ) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .notDetermined:
                // The user hasn't determined this app's access.
                completion((isAllowed: false, isLimited: false))
            case .denied, .restricted:
                // The user explicitly denied this app's access.
                completion((isAllowed: false, isLimited: false))
            case .authorized:
                // The user authorized this app to access Photos data.
                completion((isAllowed: true, isLimited: false))
            case .limited:
                // The user authorized this app for limited Photos access.
                completion((isAllowed: true, isLimited: true))
            @unknown default:
                fatalError()
            }
        }
    }
    
}
