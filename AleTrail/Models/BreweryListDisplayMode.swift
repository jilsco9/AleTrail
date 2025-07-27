//
//  BreweryListDisplayMode.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/27/25.
//

import Foundation

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
