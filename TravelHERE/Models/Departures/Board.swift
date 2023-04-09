//
//  Board.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 10/4/2023.
//

import Foundation

struct Board: Decodable, Identifiable {
    let place: Place
    let departures: [Departure]
    var id: String { "\(place.id)" }
}
