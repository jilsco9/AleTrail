//
//  BreweryService.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/24/25.
//

import Foundation

protocol BreweryService {
    func getBreweries(
        page: Int
    ) async throws(BreweryServiceError) -> [Brewery]
    
    // Note: Functionality cut for scope
    func getBreweries(
        byCity city: String,
        page: Int
    ) async throws(BreweryServiceError) -> [Brewery]
    
    func getBrewery(id: String) async throws(BreweryServiceError) -> Brewery
}
