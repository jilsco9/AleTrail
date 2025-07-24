//
//  AleTrailBreweryService.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/24/25.
//

import Foundation

actor AleTrailBreweryService: BreweryService {
    let network = AleTrailNetworking()
    
    func getBreweries(byIDs ids: [String], page: Int = 1) async throws(BreweryServiceError) -> [Brewery] {
        let url = try await BreweryServiceEndpoint.favorites(ids: ids, page: page).getURL()
        
        do {
            print(url)
            return try await network.sendGetRequest(to: url, type: [Brewery].self)
        } catch {
            throw .networkingError(error)
        }
    }
    
    func getBreweries(page: Int = 1) async throws(BreweryServiceError) -> [Brewery] {
        let url = try await BreweryServiceEndpoint.list(page: page).getURL()
        
        do {
            return try await network.sendGetRequest(to: url, type: [Brewery].self)
        } catch {
            throw .networkingError(error)
        }
    }
    
    func getBreweries(byCity city: String, page: Int = 1) async throws(BreweryServiceError) -> [Brewery] {
        let url = try await BreweryServiceEndpoint.search(city: city, page: page).getURL()
        
        do {
            return try await network.sendGetRequest(to: url, type: [Brewery].self)
        } catch {
            throw .networkingError(error)
        }
    }
}
