//
//  LocationService.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import Foundation
import CoreLocation

final class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationService()
    
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override private init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
