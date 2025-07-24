//
//  BreweryServiceError.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/24/25.
//

import Foundation

enum BreweryServiceError: Error {
    case invalidEndpoint
    case networkingError(NetworkingError)
}
