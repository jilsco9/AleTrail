//
//  BreweryFavorite.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/31/25.
//

import SwiftData

@Model final class BreweryFavorite: Identifiable {
    var id: String
    var name: String
//    var settings: Settings /// Establishes a required inverse relationship. That is, when this favorite is removed from the Settings.favorites list, it will be deleted from the model context
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
//        self.settings = settings
    }
}
