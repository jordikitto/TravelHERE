//
//  HereService.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import Foundation
import CoreLocation

final class HereService {
    static let shared = HereService()
    
    private let apiKey = "jV07PIw_7_xqnkJSk6-OHWLXdzCYNZjBOn8zKt-1uaA"
    private let transitHost = "transit.hereapi.com"
    private let weatherHost = "weather.hereapi.com"
    
    private init() { }
    
    func getDepartures(location: CLLocationCoordinate2D) async throws -> [Board] {
        guard let departuresURL = departuresURL(location: location) else { throw URLError(.badURL) }
        
        print(departuresURL.absoluteString)
        let (data, response) = try await URLSession.shared.data(from: departuresURL)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        do {
            let boards = try decoder.decode([Board].self, from: data)
            return boards
        } catch {
            throw URLError(.cannotParseResponse)
        }
    }
    
    private func departuresURL(location: CLLocationCoordinate2D) -> URL? {
        var components = baseURLComponents(host: transitHost)
        components.path = "/v8/departures"
        components.queryItems?.append(contentsOf: [
            URLQueryItem(name: "in", value: "\(location.latitude),\(location.longitude)"),
            URLQueryItem(name: "maxPlaces", value: "20")
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
