//
//  NetworkingError.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/24/25.
//

import Foundation

enum NetworkingError: LocalizedError {
    
    case decodingError(DecodingError)
    case urlError(URLError)
    case other(Error)
    
    var errorDescription: String? {
        switch self {
        case .decodingError(let error):
            return error.errorDescription ?? "Decoding error"
        case .urlError(let error):
            return error.localizedDescription
        case .other(let error):
            return error.localizedDescription
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .decodingError(let error):
            error.localizedDescription
        case .urlError(let error):
            error.localizedDescription
        case .other(let error):
            error.localizedDescription
        }
    }
    
    var failureReason: String? {
        switch self {
        case .decodingError(let decodingError):
            return decodingError.failureReason
        case .urlError(let urlError):
            return "Failed with code: \(urlError.code)"
        case .other:
            return "An unknown error occurred."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .decodingError(let decodingError):
            decodingError.recoverySuggestion
        case .urlError:
            nil
        case .other:
            "Please try again."
        }
    }
}
