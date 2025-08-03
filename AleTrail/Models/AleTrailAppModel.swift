//
//  AleTrailAppModel.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/25/25.
//

import Foundation

/// The main data model for the app
///
/// Interacts with the BreweryService to get breweries -- paginated lists of either the full list of
/// breweries, a list of breweries by ID, or a list of breweries by city.
///
/// Keeps track of errors thrown from the service and current loading state. Also keeps track
/// of the pagination information for fetching breweries.
@MainActor @Observable class AleTrailAppModel {
    let breweryService: BreweryService
    var breweries: [Brewery] = []
    var allBreweriesHaveBeenLoaded: Bool = false
    var loading: Bool = true
    var breweryServiceError: BreweryServiceError?
    var hasBreweryServiceError: Bool = false
    var lastLoadedBreweryPage: Int = 1
    var lastLoadedBreweryID: String?
    var hasErrorOnPageLoad: Bool = false
        
    init(
        breweryService: BreweryService
    ) {
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
    
    func retryFailedPageFetch() async {
        allBreweriesHaveBeenLoaded = false
        await getBreweryList(initialFetch: false)
    }
    
    func getBreweryList(initialFetch: Bool) async {
        if initialFetch {
            allBreweriesHaveBeenLoaded = false
            breweries = []
        }
        
        guard !allBreweriesHaveBeenLoaded else { return }
        
        loading = true
        
        updatePage(initialFetch: initialFetch)
        
        do {
            let result = try await breweryService.getBreweries(page: lastLoadedBreweryPage)
            hasBreweryServiceError = false
            hasErrorOnPageLoad = false
            breweryServiceError = nil
            updateBreweries(result: result, initialFetch: initialFetch)
        } catch {
            debugPrint("Error fetching brewery list: \(error.errorDescription ?? "BreweryServiceError")")
            allBreweriesHaveBeenLoaded = true
            breweryServiceError = error
            hasBreweryServiceError = true
            hasErrorOnPageLoad = !initialFetch
            
            // Set page back one if required
            if lastLoadedBreweryPage > 1 {
                lastLoadedBreweryPage -= 1
            }
        }
        
        loading = false
    }
    
    func getBreweryByID(_ id: String) async throws(BreweryServiceError) -> Brewery {
        return try await breweryService.getBrewery(id: id)
    }
}
