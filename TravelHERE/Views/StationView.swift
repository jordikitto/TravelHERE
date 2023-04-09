//
//  StationView.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import SwiftUI
import MapKit

struct StationView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Map(
                coordinateRegion: .constant(viewModel.mapRegion),
                interactionModes: [],
                annotationItems: [viewModel.place]
            ) { mapPlace in
                MapMarker(coordinate: mapPlace.location.coordinate)
            }
            .frame(maxHeight: 200)
            .overlay(alignment: .bottomTrailing) {
                if let observation = viewModel.weatherObservation {
                    ObservationLabel(observation: observation)
                        .padding(5)
                        .transition(.move(edge: .bottom))
                }
            }
            .animation(.easeOut, value: viewModel.weatherObservation)
            
            Form {
                Section("Departures") {
                    if viewModel.departures.isEmpty {
                        Text("No departures currently running.")
                    } else {
                        List(viewModel.departures) { departure in
                            DepartureLabel(departure: departure)
                        }
                    }
                }
            }
        }
        .navigationTitle(viewModel.place.name)
        .task {
            await viewModel.getWeatherReport()
        }
    }
}

struct StationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StationView(
                viewModel: .init(
                    place: .wynyard,
                    departures: [.preview, .preview, .preview]
                )
            )
        }
    }
}
