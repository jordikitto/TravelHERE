//
//  BoardResponse.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

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
    let color: Color?
    let textColor: Color?
    let headsign: String
    let shortName: String
    let longName: String
    
    init(
        mode: Mode,
        name: String,
        category: String,
        color: String,
        textColor: String,
        headsign: String,
        shortName: String,
        longName: String
    ) {
        self.mode = mode
        self.name = name
        self.category = category
        self.color = Color(hex: color)
        self.textColor = Color(hex: textColor)
        self.headsign = headsign
        self.shortName = shortName
        self.longName = longName
    }
    
    enum CodingKeys: String, CodingKey {
        case mode
        case name
        case category
        case color
        case textColor
        case headsign
        case shortName
        case longName
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.mode = try container.decode(Mode.self, forKey: .mode)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        self.headsign = try container.decode(String.self, forKey: .headsign)
        self.shortName = try container.decode(String.self, forKey: .shortName)
        self.longName = try container.decode(String.self, forKey: .longName)
        self.color = Color(hex: try container.decode(String.self, forKey: .color))
        self.textColor = Color(hex: try container.decode(String.self, forKey: .textColor))
    }

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
