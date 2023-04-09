//
//  Transport.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 10/4/2023.
//

import Foundation
import SwiftUI

struct Transport: Decodable {
    let mode: Mode
    let name: String
    let category: String
    let color: Color?
    let textColor: Color?
    let headsign: String
    let shortName: String
    let longName: String
    
    init(
        mode: Mode,
        name: String,
        category: String,
        color: String,
        textColor: String,
        headsign: String,
        shortName: String,
        longName: String
    ) {
        self.mode = mode
        self.name = name
        self.category = category
        self.color = Color(hex: color)
        self.textColor = Color(hex: textColor)
        self.headsign = headsign
        self.shortName = shortName
        self.longName = longName
    }
    
    enum CodingKeys: String, CodingKey {
        case mode
        case name
        case category
        case color
        case textColor
        case headsign
        case shortName
        case longName
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.mode = try container.decode(Mode.self, forKey: .mode)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        self.headsign = try container.decode(String.self, forKey: .headsign)
        self.shortName = try container.decode(String.self, forKey: .shortName)
        self.longName = try container.decode(String.self, forKey: .longName)
        self.color = Color(hex: try container.decode(String.self, forKey: .color))
        self.textColor = Color(hex: try container.decode(String.self, forKey: .textColor))
    }

    enum Mode: String, Decodable {
        case highSpeedTrain
        case intercityTrain
        case interRegionalTrain
        case regionalTrain
        case cityTrain
        case bus
        case ferry
        case subway
        case lightRail
        case privateBus
        case inclined
        case aerial
        case busRapid
        case monorail
        case flight
        case spaceship
    }
}
