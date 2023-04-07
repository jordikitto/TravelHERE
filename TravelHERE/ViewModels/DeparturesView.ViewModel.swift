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
        @Published private(set) var locationManager: LocationService
        @Published private(set) var state: State
        @Published private(set) var places: [Place]
        
        private let hereService: HereService
        private var cancellables = Set<AnyCancellable>()
        
        init(
            locationManager: LocationService = .shared,
            hereService: HereService = .shared
        ) {
            self.locationManager = locationManager
            self.hereService = hereService
            self.places = []
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
        
        private func requestDepartures(location: CLLocationCoordinate2D) {
            Task {
                do {
                    let boards = try await hereService.getDepartures(location: location)
                    await MainActor.run { places = boards.map(\.place) }
                } catch {
                    if let localisedError = error as? LocalizedError,
                       let errorDescription = localisedError.errorDescription
                    {
                        print(errorDescription)
                    } else {
                        print(error.localizedDescription)
                    }
                }
                
                await MainActor.run { state = .loaded }
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
