//
//  LocationManager.swift
//  MapDemo
//
//  Created by Darshan Kalathiya on 04/02/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    private var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    
    var onLocationUpdate: ((CLLocation) -> Void)?  // Callback Closure
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = kCLDistanceFilterNone
        locationManager?.pausesLocationUpdatesAutomatically = false
    }
    
    func requestLocationPermission() {
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation(onUpdate: @escaping (CLLocation) -> Void) {
        self.onLocationUpdate = onUpdate
        locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager?.stopUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        currentLocation = latestLocation
        print("Updated Location: \(latestLocation.coordinate.latitude), \(latestLocation.coordinate.longitude)")
        
        onLocationUpdate?(latestLocation)  // Call the callback closure
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to update location: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .notDetermined:
                print("Location permission not determined")
            case .restricted, .denied:
                print("Location access denied")
            case .authorizedWhenInUse, .authorizedAlways:
                print("Location access granted")
                locationManager?.startUpdatingLocation()
            @unknown default:
                print("Unknown location authorization status")
        }
    }
}
