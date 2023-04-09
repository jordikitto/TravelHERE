//
//  APIError.swift
//  TravelHERE
//
//  Created by Jordi Kitto on 7/4/2023.
//

import Foundation

enum APIError: LocalizedError {
    case badURL
    case badStatusCode(Int?)
    case responseDecodeFailure
    case emptyData
    case invalidHTTPResponse
    
    var errorDescription: String? {
        switch self {
        case .badURL: return "Unable to form request URL."
        case .badStatusCode(let code): return "\(String(describing: code)) response code from server."
        case .responseDecodeFailure: return "Unable to decode response."
        case .emptyData: return "Server returned empty data."
        case .invalidHTTPResponse: return "HTTP response was not valid."
        }
    }
}

