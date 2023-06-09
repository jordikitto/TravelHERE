//
//  HereService.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import Foundation
import CoreLocation

/// Handles getting data from HERE API.
final class HereService {
    static let shared = HereService()
    
    private let apiKey = "jV07PIw_7_xqnkJSk6-OHWLXdzCYNZjBOn8zKt-1uaA"
    private let transitHost = "transit.hereapi.com"
    private let weatherHost = "weather.hereapi.com"
    
    private init() { }
    
    func getDepartures(location: CLLocationCoordinate2D) async throws -> [Board] {
        guard let departuresURL = departuresURL(location: location) else { throw APIError.badURL }
        let data = try await getData(from: departuresURL)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let boardsResponse = try decoder.decode(BoardResponse.self, from: data)
        return boardsResponse.boards
    }

    func getWeatherReport(location: CLLocationCoordinate2D) async throws -> Observation? {
        guard let weatherReportURL = weatherReportURL(location: location) else { throw APIError.badURL }
        let data = try await getData(from: weatherReportURL)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
        return weatherResponse.places.first?.observations.first
    }
    
    private func getData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidHTTPResponse
        }
        guard httpResponse.statusCode == 200 else {
            throw APIError.badStatusCode(httpResponse.statusCode)
        }
        guard !data.isEmpty else {
            throw APIError.emptyData
        }
        return data
    }

    private func weatherReportURL(location: CLLocationCoordinate2D) -> URL? {
        var components = baseURLComponents(host: weatherHost)
        components.path = "/v3/report"
        components.queryItems?.append(contentsOf: [
            URLQueryItem(name: "location", value: "\(location.latitude),\(location.longitude)"),
            URLQueryItem(name: "products", value: "observation"),
            URLQueryItem(name: "oneObservation", value: "true")
        ])
        return components.url
    }
    
    private func departuresURL(location: CLLocationCoordinate2D) -> URL? {
        var components = baseURLComponents(host: transitHost)
        components.path = "/v8/departures"
        components.queryItems?.append(contentsOf: [
            URLQueryItem(name: "in", value: "\(location.latitude),\(location.longitude)"),
            URLQueryItem(name: "maxPlaces", value: "20"),
            URLQueryItem(name: "maxPerBoard", value: "10")
        ])
        return components.url
    }
    
    private func baseURLComponents(host: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.queryItems = [.init(name: "apiKey", value: apiKey)]
        return components
    }
 }
