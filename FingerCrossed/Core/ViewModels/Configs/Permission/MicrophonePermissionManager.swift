//
//  MicrophonePermissionManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/21/23.
//

import Foundation
import AVFoundation

final class AudioPermissionManager {
    
    let alertTitle: String = "Allow microphone access in device settings"
    
    let alertMessage: String = "Finger Crossed uses your device's microphone so you can record voice message."
    
    public var permissionStatus: PermissionStatus {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
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
        AVAudioSession.sharedInstance().requestRecordPermission { authStatus in
           DispatchQueue.main.async {
               completion(authStatus, nil)
           }
        }
    }
}
