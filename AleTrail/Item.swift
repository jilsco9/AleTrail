//
//  Item.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/23/25.
//

import Foundation
import SwiftData

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

@Model final class FavoriteBreweries: Identifiable {
    var ids: Set<String>
    
    init(ids: Set<String>) {
        self.ids = ids
    }
}
