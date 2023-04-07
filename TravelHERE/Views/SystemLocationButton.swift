//
//  SystemLocationButton.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import SwiftUI
import CoreLocationUI

struct SystemLocationButton: View {
    let action: () -> Void
    
    init(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        LocationButton(.currentLocation) {
            action()
        }
        .symbolVariant(.fill)
        .labelStyle(.titleAndIcon)
        .foregroundColor(.white)
        .cornerRadius(20)
    }
}

struct SystemLocationButton_Previews: PreviewProvider {
    static var previews: some View {
        SystemLocationButton {
            print("Access location")
        }
    }
}
