//
//  LocationPermissionManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/22/23.
//

import Foundation
import MapKit

final class LocationPermissionManager:
    NSObject,
    CLLocationManagerDelegate {
    
    var completionHandler: ((Bool, Error?) -> Void)?
    
    var locationManager = CLLocationManager()

    let alertTitle: String = "Allow location access in device settings"
    
    let alertMessage: String = "Finger Crossed uses this to show you who's around."

    public var permissionStatus: PermissionStatus {
        switch locationManager.authorizationStatus {
        case .authorizedAlways:
            return .authorized
        case .authorizedWhenInUse:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }

    public func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        if status == .notDetermined {
            return
        }
        
        if let completionHandler = completionHandler {
            let status = self.locationManager.authorizationStatus

            completionHandler(
                status == .authorizedAlways || status == .authorizedWhenInUse ? true : false,
                nil
            )
        }
    }
    
    public func requestPermission(
        completion: @escaping (Bool, Error?) -> Void
    ) {
        self.completionHandler = completion
        
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        default:
            completion(
                status == .authorizedWhenInUse || status == .authorizedAlways ? true : false,
                nil
            )
        }
    }
}
