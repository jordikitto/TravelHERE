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
