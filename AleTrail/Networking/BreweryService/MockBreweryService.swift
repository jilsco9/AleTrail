//
//  MockBreweryService.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import Foundation

actor MockBreweryService: BreweryService {
    func getBreweries(byIDs ids: [String], page: Int) async throws(BreweryServiceError) -> [Brewery] {
        return await Brewery.previewList.filter { ids.contains($0.id) }
    }
    
    func getBreweries(page: Int) async throws(BreweryServiceError) -> [Brewery] {
        return await Brewery.previewList
    }
    
    func getBreweries(byCity city: String, page: Int) async throws(BreweryServiceError) -> [Brewery] {
        return await Brewery.previewList.filter { brewery in
            brewery.city?.lowercased().contains(city.lowercased()) ?? false
        }
    }
}
