//
//  DeparturesView.ViewModel.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import Foundation
import Combine
import CoreLocation

extension DeparturesView {
    final class ViewModel: ObservableObject {
        @Published private(set) var locationManager: LocationManager
        @Published private(set) var state: State
        
        private var cancellables = Set<AnyCancellable>()
        
        init() {
            self.locationManager = LocationManager()
            self.state = .locationUnknown
            
            locationManager.$location
                .sink { [weak self] newLocation in
                    guard let newLocation else { return }
                    self?.requestDepartures(location: newLocation)
                }
                .store(in: &cancellables)
        }
        
        func requestLocation() {
            state = .loading
            locationManager.requestLocation()
        }
        
        func requestDepartures(location: CLLocationCoordinate2D) {
            state = .loading
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = "transit.hereapi.com"
            components.path = "/v8/departures"
            components.queryItems = [
                URLQueryItem(name: "apiKey", value: "jV07PIw_7_xqnkJSk6-OHWLXdzCYNZjBOn8zKt-1uaA"),
                URLQueryItem(name: "in", value: "\(location.latitude),\(location.longitude)"),
                URLQueryItem(name: "maxPlaces", value: "20")
            ]
            
            if let url = components.url {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                        print("Unexpected response status code")
                        return
                    }
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        print("Response: \(dataString)")
                        DispatchQueue.main.async {
                            self.state = .loaded
                        }
                    }
                }
                task.resume()
            } else {
                print("Invalid URL")
            }
        }
    }
}

extension DeparturesView.ViewModel {
    enum State {
        case locationUnknown
        case loading
        case loaded
        case error(Error)
        
        var isLoading: Bool {
            switch self {
            case .loading: return true
            default: return false
            }
        }
    }
}
