//
//  Settings+Preview.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import Foundation

/// Extension that hold sample data for previews
extension Settings {
    static var preview: Settings = {
        Settings(
            favoriteBreweries: Brewery.previewFavoritesList.map { BreweryFavorite(id: $0.id, name: $0.name) }
        )
    }()
}
