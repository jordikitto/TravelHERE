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
        VStack {
            LocationButton(.currentLocation) {
                viewModel.requestLocation()
            }
            .symbolVariant(.fill)
            .labelStyle(.titleAndIcon)
            .foregroundColor(.white)
            .cornerRadius(20)
            .disabled(viewModel.state.isLoading)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DeparturesView()
    }
}
