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
    case tooManyIDs
    
    var errorDescription: String? {
        switch self {
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .networkingError(let networkingError):
            return networkingError.errorDescription
        case .tooManyIDs:
            return "Too many IDs provided in request"
        }
    }
    
    var localizedError: String {
        switch self {
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .networkingError(let networkingError):
            return networkingError.localizedDescription
        case .tooManyIDs:
            return "Too many IDs provided in request"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .invalidEndpoint:
            "Could not construct a valid URL with the given path."
        case .networkingError(let networkingError):
            networkingError.failureReason
        case .tooManyIDs:
            "Tried fetching too many IDs. The brewery service only permits \(BreweryServiceEndpoint.maxIDs) IDs to be fetched at one time."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .invalidEndpoint:
            nil
        case .networkingError(let networkingError):
            networkingError.recoverySuggestion
        case .tooManyIDs:
            "Please remove some breweries from favorites. This will be fixed in a future version."
        }
    }
}
