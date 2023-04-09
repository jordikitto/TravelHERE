//
//  WeatherResponse.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import Foundation

struct WeatherResponse: Decodable {
    let places: [WeatherPlace]
}

struct WeatherPlace: Decodable {
    let observations: [Observation]
}

struct Observation: Decodable, Equatable {
    let daylight: String
    let description: String
    let skyInfo: Int
    let skyDesc: String
    let temperature: Double
    let temperatureDesc: String
    let iconId: Int
    let iconName: String
    let iconLink: String
    
    static var preview: Observation {
        .init(
            daylight: "day",
            description: "Passing clouds. Cool.",
            skyInfo: 7,
            skyDesc: "Passing clouds",
            temperature: 13,
            temperatureDesc: "Cool",
            iconId: 2,
            iconName: "mostly_sunny",
            iconLink: "https://weather.hereapi.com/static/weather/icon/2.png"
        )
    }
}
