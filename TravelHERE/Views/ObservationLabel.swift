//
//  ObservationLabel.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 10/4/2023.
//

import SwiftUI

struct ObservationLabel: View {
    let observation: Observation
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: observation.iconLink)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 30, maxHeight: 30)
            
            Text(observation.description)
        }
        .padding(10)
        .background(
            .thickMaterial,
            in: RoundedRectangle(cornerRadius: 10, style: .continuous)
        )
    }
}

struct ObservationLabel_Previews: PreviewProvider {
    static var previews: some View {
        ObservationLabel(observation: .preview)
    }
}
