//
//  Place.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 10/4/2023.
//

import Foundation

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
