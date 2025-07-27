//
//  AleTrailAppModel.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/25/25.
//

import Foundation

// TODO: - Make a note? That this is not how I would prefer to name this.
// Normally it would be more limited in scope... properly modular.
// But this is a small app and may have a small enough scope that one single
// aggregate data model makes sense

enum ListDisplayMode: String, Identifiable, CaseIterable {
    case all
    case favorites
    
    var id: ListDisplayMode {
        self
    }
    
    var title: String {
        rawValue.capitalized
    }
    
    var systemImage: String {
        switch self {
        case .all:
            "list.bullet"
        case .favorites:
            "heart"
        }
    }
}

@MainActor @Observable class AleTrailAppModel {
    let breweryService: BreweryService
    
    var breweries: [Brewery] = []
    var displayedPage: Int = 1
    
    var favoriteIDs: [String] = []
    
    var displayMode: ListDisplayMode = .all {
        didSet {
            switch displayMode {
            case .all:
                Task {
                    try? await getBreweryList(initialFetch: true)
                }
            case .favorites:
                Task {
                    try? await getBreweriesByIDs(Array(favoriteIDs), initialFetch: true)
                }
            }
        }
    }
    
    init(breweryService: BreweryService) {
        self.breweryService = breweryService
    }
    
    // TODO: - Don't like this
    func setFavoriteIDs(ids: [String]) {
        self.favoriteIDs = ids
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
    
    func getBreweriesByIDs(_ ids: [String], initialFetch: Bool = false) async throws {
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
    
    func getBreweryList(initialFetch: Bool) async throws {
        updatePage(initialFetch: initialFetch)
        let result = try await breweryService.getBreweries(page: displayedPage)
        updateBreweries(result: result, initialFetch: initialFetch)
    }
    
    func getBreweriesByCity(_ city: String, initialFetch: Bool) async throws {
        updatePage(initialFetch: initialFetch)
        let result = try await breweryService.getBreweries(byCity: city, page: displayedPage)
        updateBreweries(result: result, initialFetch: initialFetch)
    }
}
