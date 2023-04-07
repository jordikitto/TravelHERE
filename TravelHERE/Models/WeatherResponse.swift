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
    let place: PlaceInfo
    let daylight: String
    let description: String
    let skyInfo: Int
    let skyDesc: String
    let temperature: Double
    let temperatureDesc: String
    let comfort: String
    let highTemperature: String
    let lowTemperature: String
    let humidity: String
    let dewPoint: Double
    let precipitation24H: Double
    let precipitationProbability: Int
    let precipitationDesc: String
    let rainFall: Double
    let windSpeed: Double
    let windDirection: Int
    let windDesc: String
    let windDescShort: String
    let uvIndex: Int
    let uvDesc: String
    let visibility: Double
    let iconId: Int
    let iconName: String
    let iconLink: String
    let ageMinutes: Int
    let activeAlerts: Int
    let time: String
}

struct PlaceInfo: Decodable, Equatable {
    let address: Address
    let location: Location
    let distance: Double
}

struct Address: Decodable, Equatable {
    let countryCode: String
    let countryName: String
    let state: String
    let city: String
}
