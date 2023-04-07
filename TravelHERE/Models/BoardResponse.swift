//
//  BoardResponse.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import Foundation
import CoreLocation
import MapKit

struct BoardResponse: Decodable {
    let boards: [Board]
}

struct Board: Decodable, Identifiable {
    let place: Place
    let departures: [Departure]
    var id: String { "\(place.id)" }
}

struct Place: Decodable, Identifiable {
    let name: String
    let type: String
    let location: Location
    let id: String
    let code: String?
    
    static let wynyard = Place(
        name: "Wynyard Station",
        type: "station",
        location: .init(
            lat: -33.86553621612316,
            lng: 151.20614221172298
        ),
        id: "123",
        code: nil
    )
}

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

struct Departure: Decodable, Identifiable {
    let time: Date
    let delay: Int?
    let transport: Transport
    let agency: Agency
    var id: String { "\(time),\(transport.name),\(agency.id)" }
}

extension Departure {
    static func mock() -> Departure {
        .init(
            time: .now.addingTimeInterval(.random(in: 0...(2 * 60 * 60))),
            delay: nil,
            transport: .init(
                mode: .regionalTrain,
                name: "T7",
                category: "Rail",
                color: "#6F818E",
                textColor: "#FFFFFF",
                headsign: "Central",
                shortName: "T7",
                longName: "Olympic Park to Central"
            ),
            agency: .init(
                id: "123",
                name: "Sydney Trains",
                website: "https://transportnsw.info/"
            )
        )
    }
}

struct Transport: Decodable {
    let mode: Mode
    let name: String
    let category: String
    let color: String
    let textColor: String
    let headsign: String
    let shortName: String
    let longName: String
    
    enum Mode: String, Decodable {
        case highSpeedTrain
        case intercityTrain
        case interRegionalTrain
        case regionalTrain
        case cityTrain
        case bus
        case ferry
        case subway
        case lightRail
        case privateBus
        case inclined
        case aerial
        case busRapid
        case monorail
        case flight
        case spaceship
    }

}

struct Agency: Decodable {
    let id: String
    let name: String
    let website: String
}
