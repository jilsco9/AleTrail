//
//  MockBreweryService.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import Foundation

actor MockBreweryService: BreweryService {
    func getBreweries(byIDs ids: [String], page: Int) async throws(BreweryServiceError) -> [Brewery] {
//        return await Brewery.previewFavoritesList // TODO: - can actually return a .filter where ids.contains the brewery id
        throw BreweryServiceError.networkingError(NetworkingError.urlError(URLError(.badURL)))
    }
    
    func getBreweries(page: Int) async throws(BreweryServiceError) -> [Brewery] {
        return await Brewery.previewList
    }
    
    func getBreweries(byCity city: String, page: Int) async throws(BreweryServiceError) -> [Brewery] {
        return await Brewery.previewSantaCruzList // TODO: - can actually return a .filter where city name equals entered city
    }
}
