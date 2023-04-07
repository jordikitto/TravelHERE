//
//  DeparturesResponse.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import Foundation

struct Board: Decodable {
    let place: Place
    let departures: [Departure]
}

struct Place: Decodable {
    let name: String
    let type: String
    let location: Location
    let id: String
    let code: String
}

struct Location: Decodable {
    let lat: Double
    let lng: Double
}

struct Departure: Decodable {
    let time: String
    let delay: Int
    let transport: Transport
    let agency: Agency
}

struct Transport: Decodable {
    let mode: String
    let name: String
    let category: String
    let color: String
    let textColor: String
    let headsign: String
    let shortName: String
    let longName: String
}

struct Agency: Decodable {
    let id: String
    let name: String
    let website: String
}
