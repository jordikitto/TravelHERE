//
//  NearbyStationsView.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import SwiftUI
import CoreLocationUI

struct NearbyStationsView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                if viewModel.boards.isEmpty {
                    switch viewModel.state {
                    case .awaitingRequest, .loading:
                        Text("Tap *Current Location* to get started.")
                    case .loaded:
                        Text("There are no transit stations near you.")
                    }
                } else {
                    List(viewModel.boards) { board in
                        NavigationLink {
                            StationView(viewModel: .init(place: board.place, departures: board.departures))
                        } label: {
                            PlaceLabel(place: board.place)
                        }
                    }
                }
            }
            .navigationTitle("Nearby Stations")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack(spacing: 10) {
                        SystemLocationButton {
                            viewModel.requestLocation()
                        }
                        .disabled(viewModel.state == .loading)
                        if viewModel.state == .loading { ProgressView() }
                    }
                }
            }
            .alert("Error Occurred", isPresented: $viewModel.isPresentedLocalisedError) {
                Button("Dismiss") { viewModel.isPresentedLocalisedError = false }
            } message: {
                Text(viewModel.localisedError?.errorDescription ?? "Unknown error. Please contact support.")
            }
            .animation(.easeOut, value: viewModel.state)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyStationsView()
    }
}
