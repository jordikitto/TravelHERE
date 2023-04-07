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
}
