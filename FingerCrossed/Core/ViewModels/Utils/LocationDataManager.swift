//
//  LocationDataManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/23/23.
//

import Foundation
import CoreLocation

class LocationDataManager:
    NSObject,
    ObservableObject,
    CLLocationManagerDelegate {
    
    @Published var lastSeenLocation: CLLocation?

    @Published var currentPlacemark: CLPlacemark?
    
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            locationManager.stopUpdatingLocation()
        case .restricted, .denied:
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        self.lastSeenLocation = locations.first
        fetchCountryAndCity(for: locations.first)
    }
        
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error.localizedDescription)
    }
    
    func fetchCountryAndCity(
        for location: CLLocation?
    ) {
        guard let location = location else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else { return }
            self.currentPlacemark = placemarks?.first
        }
    }
}
