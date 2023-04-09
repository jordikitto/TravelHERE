//
//  StandardError.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 10/4/2023.
//

import Foundation

enum StandardError: LocalizedError {
    case message(String)
    
    var errorDescription: String? {
        switch self {
        case .message(let message): return message
        }
    }
}
