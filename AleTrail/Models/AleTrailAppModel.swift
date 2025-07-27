//
//  AleTrailAppModel.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/25/25.
//

import Foundation

@MainActor @Observable class AleTrailAppModel {
    let breweryService: BreweryService
    
    var breweries: [Brewery] = []
    var displayedPage: Int = 1
        
    init(breweryService: BreweryService) {
        self.breweryService = breweryService
    }
    
    private func updatePage(initialFetch: Bool) {
        if initialFetch {
            displayedPage = 1
        } else {
            displayedPage += 1
        }
    }
    
    private func updateBreweries(result: [Brewery], initialFetch: Bool) {
        if initialFetch {
            breweries = result
        } else {
            breweries.append(contentsOf: result)
        }
    }
    
    func getBreweriesByIDs(_ ids: [String], initialFetch: Bool = false) async throws(BreweryServiceError) {
        updatePage(initialFetch: initialFetch)
        
        var result: [Brewery]
        
        // TODO: - Add note:
        /// If ids is empty, simply set breweries to an empty list.
        /// Otherwise, if the getBreweries call is made with an empty array,
        /// the OpenBreweryDB API returns a list of breweries as if the call
        /// was made without the `byIDs` query item.
        // TODO: - May actually want to consider whether we want
        // to catch that in the service itself.
        if ids.isEmpty {
            result = []
        } else {
            result = try await breweryService.getBreweries(byIDs: ids, page: displayedPage)
        }
        updateBreweries(result: result, initialFetch: initialFetch)
    }
    
    func getBreweryList(initialFetch: Bool) async throws(BreweryServiceError) {
        updatePage(initialFetch: initialFetch)
        let result = try await breweryService.getBreweries(page: displayedPage)
        updateBreweries(result: result, initialFetch: initialFetch)
    }
    
    func getBreweriesByCity(_ city: String, initialFetch: Bool) async throws(BreweryServiceError) {
        updatePage(initialFetch: initialFetch)
        let result = try await breweryService.getBreweries(byCity: city, page: displayedPage)
        updateBreweries(result: result, initialFetch: initialFetch)
    }
}
