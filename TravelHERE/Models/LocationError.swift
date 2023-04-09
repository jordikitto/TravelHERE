//
//  LocationError.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 10/4/2023.
//

import Foundation

enum LocationError: LocalizedError {
    case accessDenied
    case unknownAuthorisationStatus
    case failure(String)
    
    var errorDescription: String? {
        switch self {
        case .accessDenied: return "Location access denied."
        case .unknownAuthorisationStatus: return "Unknown authorisation status."
        case .failure(let message): return message
        }
    }
}
