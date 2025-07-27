//
//  Settings.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import SwiftData

@Model final class Settings: Identifiable {
    var ids: Set<String>
    var displayMode: ListDisplayMode
    
    init(ids: Set<String>, listDisplayMode: ListDisplayMode = .all) {
        self.ids = ids
        self.displayMode = displayMode
    }
    
    func removeFavorite(id: String) {
        ids.remove(id)
    }
    
    func addFavorite(id: String) {
        ids.insert(id)
    }
}

//@Model
//final class FavoriteBrewery: Identifiable {
//    var id: String
//    var name: String
//    var city: String?
//    var stateProvince: String?
//
//    init(
//        id: String,
//        name: String,
//        city: String? = nil,
//        stateProvince: String? = nil
//    ) {
//        self.id = id
//        self.name = name
//        self.city = city
//        self.stateProvince = stateProvince
//    }
//}

// TODO: - ^ Setting up offline functionality, in case we want to
// display favorite breweries without even doing a network call. Might
// make sense to just save the whole Brewery model, though, actually.
