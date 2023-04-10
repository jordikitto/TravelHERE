//
//  NearbyStationsView.ViewModel.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import Foundation
import Combine
import CoreLocation

extension NearbyStationsView {
    final class ViewModel: ObservableObject {
        enum State: Equatable {
            case awaitingRequest
            case loading
            case loaded
        }
        
        @Published private(set) var locationManager: LocationService
        @Published private(set) var state: State
        @Published private(set) var boards: [Board]
        @Published private(set) var localisedError: LocalizedError? {
            didSet {
                Task {
                    await MainActor.run { isPresentedLocalisedError = localisedError != nil }
                }
            }
        }
        @Published var isPresentedLocalisedError = false
        
        private let hereService: HereService
        private var cancellables = Set<AnyCancellable>()
        private var requestTimeout: Timer? = nil
        
        init(
            locationManager: LocationService = .shared,
            hereService: HereService = .shared
        ) {
            self.locationManager = locationManager
            self.hereService = hereService
            self.boards = []
            self.state = .awaitingRequest
            
            locationManager.$location
                .sink { [weak self] newLocation in
                    guard let newLocation else { return }
                    self?.requestDepartures(location: newLocation)
                }
                .store(in: &cancellables)
            
            locationManager.$locationError
                .sink { [weak self] locationError in
                    guard let locationError,
                          let self
                    else { return }
                    
                    Task {
                        await MainActor.run {
                            self.localisedError = locationError
                            self.state = .awaitingRequest
                        }
                    }
                }
                .store(in: &cancellables)
        }
        
        func requestLocation() {
            state = .loading
            locationManager.requestLocation()
            
            // Start timeout, for issues with internet or when user taps "Not now".
            requestTimeout = Timer.scheduledTimer(withTimeInterval: 20, repeats: false) { [weak self] _ in
                guard let self else { return }
                Task { await MainActor.run { self.state = .awaitingRequest} }
            }
        }
        
        private func requestDepartures(location: CLLocationCoordinate2D) {
            Task {
                do {
                    let boards = try await hereService.getDepartures(location: location)
                    await MainActor.run {
                        self.boards = boards
                        self.state = .loaded
                        self.requestTimeout?.invalidate()
                    }
                } catch {
                    let localisedError = error as? LocalizedError ?? StandardError.message(error.localizedDescription)
                    await MainActor.run {
                        self.localisedError = localisedError
                        self.state = .awaitingRequest
                        self.requestTimeout?.invalidate()
                    }
                }
            }
        }
    }
}
