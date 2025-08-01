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
    
    var hasErrorOnPageLoad: Bool {
        breweryServiceError != nil && lastLoadedBreweryPage > 1
    }
        
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
            breweryServiceError = nil
            updateBreweries(result: result, initialFetch: initialFetch)
        } catch {
            debugPrint("Error fetching brewery list: \(error.errorDescription ?? "BreweryServiceError")")
            allBreweriesHaveBeenLoaded = true
            breweryServiceError = error
            hasBreweryServiceError = true
            
            // Set page back one if required
            if lastLoadedBreweryPage > 1 {
                lastLoadedBreweryPage -= 1
            }
        }
        
        loading = false
    }
    
    /// - Warning: Discovered via testing that there is a limit to how many ids can be searched at
    /// one time. This limit seems to be about 6, but it is not documented on the OpenBrewery API.
    /// We would need to implement custom pagination, fetching only 6 favorites at a time.
    ///
    func getBreweriesByID(_ ids: [String], initialFetch: Bool = false) async {
        if initialFetch {
            allBreweriesHaveBeenLoaded = false
            breweries = []
        }
        
        guard !allBreweriesHaveBeenLoaded else { return }
        
        loading = true
        
        updatePage(initialFetch: initialFetch)
        
        do {
            var result: [Brewery]
            
            /// If ID array is empty to begin with, go ahead and set result to an empty array.
            /// Note: If we allow the fetch by IDs to happen with an empty array, the current service,
            /// OpenBreweryDB, proceeds with the fetch as if no ids query item was passed,
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
            allBreweriesHaveBeenLoaded = true
            breweryServiceError = error
            hasBreweryServiceError = true
            
            // Set page back one if required
            if lastLoadedBreweryPage > 1 {
                lastLoadedBreweryPage -= 1
            }
        }
        
        loading = false
    }
    
    func getBreweryByID(_ id: String) async throws(BreweryServiceError) -> Brewery {
        return try await breweryService.getBrewery(id: id)
        
//        do {
//            var result: [Brewery]
//            return try await breweryService.getBreweries(byIDs: ids, page: lastLoadedBreweryPage)
//
//        } catch {
//            debugPrint("Error fetching brewery list by IDs: \(error.errorDescription ?? "BreweryServiceError")")
//            allBreweriesHaveBeenLoaded = true
//            breweryServiceError = error
//            hasBreweryServiceError = true
//            
//            // Set page back one if required
//            if lastLoadedBreweryPage > 1 {
//                lastLoadedBreweryPage -= 1
//            }
//        }
//        
//        loading = false
    }
}
