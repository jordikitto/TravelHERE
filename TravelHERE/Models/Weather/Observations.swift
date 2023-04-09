//
//  Observations.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 10/4/2023.
//

import Foundation

struct Observation: Decodable, Equatable {
    let description: String
    let iconLink: String
    
    static var preview: Observation {
        .init(
            description: "Passing clouds. Cool.",
            iconLink: "https://weather.hereapi.com/static/weather/icon/2.png"
        )
    }
}
