//
//  BreweryListItem.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/31/25.
//

import Foundation

protocol BreweryListItem: Identifiable {
    var id: String { get }
    var name: String { get }
}
