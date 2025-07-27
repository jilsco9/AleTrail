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
    var allBreweriesHaveBeenLoaded: Bool = false
    var loading: Bool = false
    var breweryServiceError: BreweryServiceError?
    var hasBreweryServiceError: Bool = false
    var lastLoadedBreweryPage: Int = 1
    var lastLoadedBreweryID: String?
        
    init(breweryService: BreweryService) {
        self.breweryService = breweryService
    }
    
    private func updatePage(initialFetch: Bool) {
        if initialFetch {
            lastLoadedBreweryPage = 1
        } else {
            lastLoadedBreweryPage += 1
        }
    }
    
    private func updateBreweries(result: [Brewery], initialFetch: Bool) {
        if initialFetch {
            breweries = result
        } else {
            breweries.append(contentsOf: result)
        }
        
        lastLoadedBreweryID = result.last?.id
        
        /// If there are no results, if there are fewer results than the max items per page,
        /// or if we have come to a page with an empty array result, we have reached
        /// the end of the results.
        if result.count < BreweryServiceEndpoint.perPage {
            allBreweriesHaveBeenLoaded = true
        }
    }
    
    func getBreweriesByIDs(_ ids: [String], initialFetch: Bool = false) async {
        if initialFetch { allBreweriesHaveBeenLoaded = false }
        
        guard !allBreweriesHaveBeenLoaded else { return }
        
        loading = true
        
        updatePage(initialFetch: initialFetch)
        
        do {
            var result: [Brewery]
            
            /// If ID array is empty to begin with, go ahead and set result to an empty array.
            /// Note: If we allow the search to happen with an empty array, the current service,
            /// OpenBreweryDB, proceeds with the search as if no ids query item was passed,
            /// meaning it will give the first page of results for all breweries, which may not be
            /// the functionality we expect. So it is best to set the result here in the app model
            /// and head off any variation in behavior from the API.
            if ids.isEmpty {
                result = []
            } else {
                result = try await breweryService.getBreweries(byIDs: ids, page: lastLoadedBreweryPage)
            }
            updateBreweries(result: result, initialFetch: initialFetch)
        } catch {
            debugPrint("Error fetching brewery list by IDs: \(error.errorDescription ?? "BreweryServiceError")")
            breweryServiceError = error
            hasBreweryServiceError = true
        }
        
        loading = false
    }
    
    func getBreweryList(initialFetch: Bool) async {
        if initialFetch { allBreweriesHaveBeenLoaded = false }
        
        guard !allBreweriesHaveBeenLoaded else { return }
        
        loading = true
        
        updatePage(initialFetch: initialFetch)
        
        do {
            let result = try await breweryService.getBreweries(page: lastLoadedBreweryPage)
            updateBreweries(result: result, initialFetch: initialFetch)
        } catch {
            debugPrint("Error fetching brewery list: \(error.errorDescription ?? "BreweryServiceError")")
            breweryServiceError = error
            hasBreweryServiceError = true
        }
        
        loading = false
    }
    
    func getBreweriesByCity(_ city: String, initialFetch: Bool) async {
        if initialFetch { allBreweriesHaveBeenLoaded = false }
        
        guard !allBreweriesHaveBeenLoaded else { return }
        
        loading = true
        
        updatePage(initialFetch: initialFetch)
        
        do {
            let result = try await breweryService.getBreweries(byCity: city, page: lastLoadedBreweryPage)
            updateBreweries(result: result, initialFetch: initialFetch)
        } catch {
            debugPrint("Error fetching brewery list by city: \(error.errorDescription ?? "BreweryServiceError")")
            breweryServiceError = error
            hasBreweryServiceError = true
        }
        
        loading = false
    }
}
