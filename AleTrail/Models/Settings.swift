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
@Model final class Settings: Identifiable {
    var favoriteBreweryIDs: Set<String>
    var breweryListDisplayMode: String
    
    init(favoriteBreweryIDs: Set<String>, listDisplayMode: BreweryListDisplayMode = .all) {
        self.favoriteBreweryIDs = favoriteBreweryIDs
        self.breweryListDisplayMode = listDisplayMode.rawValue
    }
    
    func removeFavorite(
        id: String,
        modelContext: ModelContext
    ) {
        favoriteBreweryIDs.remove(id)
        try? modelContext.save()
    }
    
    func addFavorite(
        id: String,
        modelContext: ModelContext
    ) {
        print("Inserting \(id)")
        favoriteBreweryIDs.insert(id)
        try? modelContext.save()
    }
}
