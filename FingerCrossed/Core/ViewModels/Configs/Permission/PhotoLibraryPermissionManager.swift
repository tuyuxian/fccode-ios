//
//  PhotoLibraryPermissionManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/21/23.
//

import Foundation
import Photos
import UIKit

final class PhotoLibraryPermissionManager {
    
    let alertTitle: String = "Allow photos access in device settings"
    
    let alertMessage: String = "Finger Crossed uses your device's photo library so you can share photos."
    
    typealias PhotoAuthStatus = (isAllowed: Bool, isLimited: Bool)

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
    
//    public func requestPermission(
//        completion: @escaping (Bool, Error?) -> Void
//    ) {
//        PHPhotoLibrary.requestAuthorization { authStatus in
//            switch authStatus {
//            case .authorized:
//                completion(true, nil)
//            case .notDetermined:
//                completion(false, nil)
//            case .limited:
//                completion(true, nil)
//            default:
//                completion(false, nil)
//            }
//        }
//    }
    
    public func requestPermission (completion: @escaping (PhotoAuthStatus) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
//            DispatchQueue.main.async {
//                self.showUI(for: status)
//            }
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
    
//    private func showUI(for status: PHAuthorizationStatus) {
//        switch status {
//            case .authorized:
//                showFullAccessUI()
//
//            case .limited:
//                showLimittedAccessUI()
//
//            case .restricted:
//                showRestrictedAccessUI()
//
//            case .denied:
//                showAccessDeniedUI()
//
//            case .notDetermined:
//                break
//
//            @unknown default:
//                break
//            }
//    }
}
