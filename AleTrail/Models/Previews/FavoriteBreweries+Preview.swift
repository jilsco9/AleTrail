//
//  FavoriteBreweries+Preview.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import Foundation

extension FavoriteBreweries {
    static var preview: FavoriteBreweries = {
        FavoriteBreweries(ids: Set<String>(Brewery.previewFavoritesList.map { $0.id }))
    }()
}
