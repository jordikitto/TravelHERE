//
//  BoardResponse.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import Foundation
import CoreLocation

struct BoardResponse: Decodable {
    let boards: [Board]
}

struct Board: Decodable {
    let place: Place
    let departures: [Departure]
}

struct Place: Decodable, Identifiable {
    let name: String
    let type: String
    let location: Location
    let id: String
    let code: String?
}

struct Location: Decodable {
    let lat: Double
    let lng: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}

struct Departure: Decodable {
    let time: Date
    let delay: Int?
    let transport: Transport
    let agency: Agency
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
