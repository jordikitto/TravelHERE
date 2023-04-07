//
//  PlaceLabel.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import SwiftUI
import MapKit

struct PlaceLabel: View {
    let place: Place
    
    var body: some View {
        HStack(spacing: 10) {
            Map(
                coordinateRegion: .constant(place.location.mapRegion(metresZoomed: 250)),
                interactionModes: [],
                annotationItems: [place]
            ) { mapPlace in
                MapMarker(coordinate: mapPlace.location.coordinate)
            }
            .frame(width: 80, height: 80)
            .cornerRadius(10)
            
            Text(place.name)
        }
    }
}

struct PlaceLabel_Previews: PreviewProvider {
    static var previews: some View {
        PlaceLabel(place: .wynyard)
    }
}
