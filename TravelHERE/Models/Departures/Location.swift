//
//  Location.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 10/4/2023.
//

import Foundation
import MapKit

struct Location: Decodable, Equatable {
    let lat: Double
    let lng: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
    
    func mapRegion(metresZoomed: CLLocationDistance) -> MKCoordinateRegion {
        .init(center: coordinate, latitudinalMeters: metresZoomed, longitudinalMeters: metresZoomed)
    }
}
