//
//  DeparturesView.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import SwiftUI
import CoreLocationUI

struct DeparturesView: View {
    @StateObject var viewModel: ViewModel = .init()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                LocationButton(.currentLocation) {
                    viewModel.requestLocation()
                }
                .symbolVariant(.fill)
                .labelStyle(.titleAndIcon)
                .foregroundColor(.white)
                .cornerRadius(20)
                .disabled(viewModel.state.isLoading)
                .padding(.horizontal)
                
                List(viewModel.places) { place in
                    NavigationLink {
                        Text(place.name)
                    } label: {
                        Text(place.name)
                    }
                }
            }
            .navigationTitle("Departures")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DeparturesView()
    }
}
