//
//  StationView.ViewModel.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import Foundation
import MapKit

extension StationView {
    final class ViewModel: ObservableObject {
        let place: Place
        let departures: [Departure]
        @Published var weatherObservation: Observation?
        let hereService: HereService
        
        var mapRegion: MKCoordinateRegion {
            place.location.mapRegion(metresZoomed: 250)
        }
        
        init(
            place: Place,
            departures: [Departure],
            hereService: HereService = .shared
        ) {
            self.place = place
            self.departures = departures
            self.hereService = hereService
        }
        
        func getWeatherReport() async {
            do {
                let observation = try await hereService.getWeatherReport(location: place.location.coordinate)
                await MainActor.run { self.weatherObservation = observation }
            } catch {
                if let localisedError = error as? LocalizedError,
                   let errorDescription = localisedError.errorDescription
                {
                    print(errorDescription)
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
