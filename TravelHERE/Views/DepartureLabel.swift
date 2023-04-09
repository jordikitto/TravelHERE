//
//  DepartureLabel.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import SwiftUI

struct DepartureLabel: View {
    let departure: Departure
    
    var body: some View {
        HStack {
            Text(departure.transport.shortName)
                .bold()
                .foregroundColor(departure.transport.textColor)
                .padding(10)
                .background(departure.transport.color.cornerRadius(10))
            
            Text(departure.transport.longName)
            Spacer()
            Text(departure.time.formatted(date: .omitted, time: .shortened))
                .bold()
        }
    }
}

struct DepartureLabel_Previews: PreviewProvider {
    static var previews: some View {
        DepartureLabel(departure: .preview)
            .padding()
    }
}
