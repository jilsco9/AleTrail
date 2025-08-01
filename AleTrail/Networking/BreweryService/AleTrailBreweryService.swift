//
//  AleTrailBreweryService.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/24/25.
//

import Foundation

/// Service to fetch Breweries
///
/// Uses ``BreweryServiceEndpoint`` and throws ``BreweryServiceEndpoint``
///
actor AleTrailBreweryService: BreweryService {
    let network = AleTrailNetworking()
    
    /// Get a list (one page) of breweries.
    ///
    /// Results from the service are paginated, with the max results per page
    ///  identified by ``BreweryServiceEndpoint/perPage``.
    ///
    /// - Parameters:
    ///   - page: 1-based index of paginated results
    /// - Returns: Array of Brewery models for the given page
    /// - Throws: Brewery service error -- ``BreweryServiceError/invalidEndpoint``
    ///   if the URL cannot be created or ``BreweryServiceError/networkingError(_:)``
    ///   with an associated ``NetworkingError``
    func getBreweries(
        page: Int = 1
    ) async throws(BreweryServiceError) -> [Brewery] {
        let url = try await BreweryServiceEndpoint.list(
            page: page
        ).getURL()
        
        do {
            return try await network.sendGetRequest(
                to: url
            )
        } catch {
            throw .networkingError(error)
        }
    }

    /// Get a list (one page) of breweries by city.
    ///
    /// Results from the service are paginated, with the max results per page
    ///  identified by ``BreweryServiceEndpoint/perPage``.
    ///
    /// - Parameters:
    ///   - city: Full string or partial string of city to search for breweries
    ///   - page: 1-based index of paginated results
    /// - Returns: Array of Brewery models for the given page
    /// - Throws: Brewery service error -- ``BreweryServiceError/invalidEndpoint``
    ///   if the URL cannot be created or ``BreweryServiceError/networkingError(_:)``
    ///   with an associated ``NetworkingError``
    func getBreweries(
        byCity city: String,
        page: Int = 1
    ) async throws(BreweryServiceError) -> [Brewery] {
        
        let url = try await BreweryServiceEndpoint.search(
            city: city,
            page: page
        ).getURL()
        
        do {
            return try await network.sendGetRequest(
                to: url
            )
        } catch {
            throw .networkingError(error)
        }
    }
    
    /// Get a brewery identified by ID.
    ///
    /// - Parameters:
    ///   - id: Brewery ID
    /// - Returns: Array of Brewery models for the given page
    /// - Throws: Brewery service error -- ``BreweryServiceError/invalidEndpoint``
    ///   if the URL cannot be created or ``BreweryServiceError/networkingError(_:)``
    ///   with an associated ``NetworkingError``
    func getBrewery(
        id: String
    ) async throws(BreweryServiceError) -> Brewery {
        let url = try await BreweryServiceEndpoint.getBrewery(id: id).getURL()
        
        do {
            return try await network.sendGetRequest(
                to: url
            )
        } catch {
            throw .networkingError(error)
        }
    }
}
