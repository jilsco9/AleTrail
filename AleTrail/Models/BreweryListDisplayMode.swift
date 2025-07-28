//
//  BreweryListDisplayMode.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/27/25.
//

import Foundation

/// Represents the two list modes currently available in the app:
/// - `all` for showing a list of all breweries (searchable by city)
/// - `favorites` for showing a list of breweries the user has saved as favorites
enum BreweryListDisplayMode: String, Identifiable, CaseIterable {
    case all
    case favorites
    
    var id: BreweryListDisplayMode {
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
