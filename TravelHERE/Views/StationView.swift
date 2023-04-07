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
    
    init(viewModel: ViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Map(coordinateRegion: .constant(viewModel.mapRegion), annotationItems: [viewModel.place]) { mapPlace in
                MapMarker(coordinate: mapPlace.location.coordinate)
            }
            .frame(maxHeight: 200)
            .overlay(alignment: .bottomTrailing) {
                if let observation = viewModel.weatherObservation {
                    Text(observation.description)
                        .padding(10)
                        .background(
                            .thickMaterial,
                            in: RoundedRectangle(cornerRadius: 10, style: .continuous)
                        )
                        .padding(5)
                        .transition(.move(edge: .bottom))
                        .animation(.easeOut, value: viewModel.weatherObservation)
                }
            }
            
            Form {
                Section("Departures") {
                    List(viewModel.departures) { departure in
                        DepartureLabel(departure: departure)
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
                    departures: [.mock(), .mock(), .mock()]
                )
            )
        }
    }
}
