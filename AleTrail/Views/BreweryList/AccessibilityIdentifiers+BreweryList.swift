//
//  AccessibilityIdentifiers+BreweryList.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/28/25.
//

import Foundation

extension AccessibilityIdentifiers {
    enum BreweryList: Accessibility {
        case scrollView
        case allBreweriesButton(selected: Bool)
        case favoritesButton(selected: Bool)
        case navigationTitle
        case progressIndicator
        case breweryListItem(id: String)
        case noBreweriesView
        
        var screenID: String {
            "BreweryList"
        }
        
        var componentID: String {
            switch self {
            case .scrollView:
                "scrollView"
            case .allBreweriesButton:
                "allBreweriesButton"
            case .favoritesButton:
                "favoritesButton"
            case .navigationTitle:
                "navigationTitle"
            case .progressIndicator:
                "progressIndicator"
            case .breweryListItem(let id):
                "breweryListItem.\(id)"
            case .noBreweriesView:
                "noBreweriesView"
            }
        }
        
        var accessibilityLabel: String? {
            switch self {
            case .allBreweriesButton(let selected):
                return "All Breweries \(selected ? "Selected" : "Not selected")"
            case .favoritesButton(let selected):
                return "Favorite Breweries \(selected ? "Selected" : "Not selected")"
            case .scrollView,
                    .navigationTitle,
                    .progressIndicator,
                    .breweryListItem,
                    .noBreweriesView:
                return nil
            }
        }
        
        var accessibilityHint: String? {
            switch self {
            case .allBreweriesButton(let selected):
                return selected ? nil : "Tap to show all breweries."
            case .favoritesButton(let selected):
                return selected ? nil : "Tap to show favorite breweries."
            case .scrollView,
                    .navigationTitle,
                    .progressIndicator,
                    .breweryListItem,
                    .noBreweriesView:
                return nil
            }
        }
    }
}
