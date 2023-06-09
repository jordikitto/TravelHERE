//
//  LocationService.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import Foundation
import CoreLocation

/// Handles getting user location with `CoreLocation`
final class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationService()
    
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    @Published var locationError: LocationError?

    override private init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Triggers when LocationButton is first tapped
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .restricted:
            locationError = .accessDenied
        case .notDetermined:
            break
        @unknown default:
            locationError = .unknownAuthorisationStatus
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = .failure(error.localizedDescription)
    }
}
