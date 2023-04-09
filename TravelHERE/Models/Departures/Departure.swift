//
//  Departure.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 10/4/2023.
//

import Foundation

struct Departure: Decodable, Identifiable {
    let time: Date
    let delay: Int?
    let transport: Transport
    let agency: Agency
    var id: String { "\(time),\(transport.name),\(agency.id)" }
    
    static var preview: Departure {
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
