//
//  NearbyStationsView.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import SwiftUI
import CoreLocationUI

struct NearbyStationsView: View {
    @StateObject var viewModel: ViewModel = .init()
    
    var body: some View {
        NavigationView {
            Form {
                if viewModel.boards.isEmpty {
                    Text("Tap *Current Location* to get started")
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
                    switch viewModel.state {
                    case .locationUnknown:
                        SystemLocationButton {
                            viewModel.requestLocation()
                        }
                    case .loading:
                        ProgressView()
                    case .error(let message):
                        Text(message)
                            .foregroundColor(.red)
                    case .loaded:
                        EmptyView()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyStationsView()
    }
}
