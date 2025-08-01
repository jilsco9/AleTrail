//
//  Settings.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import SwiftData

/// Persistent settings model
///
/// Persists user settings such as brewery IDs marked as favorites
/// and last viewed brewery list display mode
@MainActor
@Model final class Settings: Identifiable {
    var favoriteBreweries: [BreweryFavorite]
    var breweryListDisplayMode: String
    
    init(favoriteBreweries: [BreweryFavorite], listDisplayMode: BreweryListDisplayMode = .all) {
        self.favoriteBreweries = favoriteBreweries
        self.breweryListDisplayMode = listDisplayMode.rawValue
    }
    
    func containsFavoriteBrewery(_ brewery: Brewery) -> Bool {
        return favoriteBreweries.contains { $0.id == brewery.id }
    }
    
    func removeFavorite(
        id: String,
        modelContext: ModelContext
    ) {
        debugPrint("Removing \(id) from favorites")
        favoriteBreweries.removeAll(where: { $0.id == id })
        try? modelContext.save() // Might be able to remove this, now that it's main actor isolated?
    }
    
    func addFavorite(
        id: String,
        name: String,
        modelContext: ModelContext
    ) {
        debugPrint("Adding \(id) to favorites")
        let newFavorite = BreweryFavorite(id: id, name: name)
        favoriteBreweries.append(newFavorite)
        try? modelContext.save() // Might be able to remove this, now that it's main actor isolated?
    }
}
