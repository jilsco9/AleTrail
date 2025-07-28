//
//  BreweryServiceError.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/24/25.
//

import Foundation

enum BreweryServiceError: LocalizedError {
    case invalidEndpoint
    case networkingError(NetworkingError)
    
    var errorDescription: String? {
        switch self {
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .networkingError(let networkingError):
            return networkingError.errorDescription
        }
    }
    
    var failureReason: String? {
        switch self {
        case .invalidEndpoint:
            "Could not construct a valid URL with the given path."
        case .networkingError(let networkingError):
            networkingError.failureReason
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .invalidEndpoint:
            nil
        case .networkingError(let networkingError):
            networkingError.recoverySuggestion
        }
    }
}
