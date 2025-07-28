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
            favoriteBreweryIDs: Set<String>(
                Brewery.previewFavoritesList.map { $0.id }
            )
        )
    }()
}
