//
//  AccessibilityIdentifiers+BreweryDetail.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/28/25.
//

import Foundation

extension AccessibilityIdentifiers {
    enum BreweryDetail: Accessibility {
        case scrollView
        case generalInformation
        case breweryType(String)
        case locationInformation
        case favoriteButton(favorited: Bool)
        
        var screenID: String {
            "BreweryDetail"
        }
        
        var componentID: String {
            switch self {
            case .scrollView:
                "scrollView"
            case .generalInformation:
                "generalInformation"
            case .breweryType:
                "breweryType"
            case .locationInformation:
                "locationInformation"
            case .favoriteButton:
                "favoriteButton"
            }
        }
        
        var accessibilityLabel: String? {
            switch self {
            case .favoriteButton(let favorited):
                return "Brewery is \(favorited ? "favorited" : "not favorited")"
            case .breweryType(let type):
                return "Brewery type: \(type)"
            case .scrollView, .generalInformation, .locationInformation:
                return nil
            }
        }
        
        var accessibilityHint: String? {
            switch self {
            case .favoriteButton(let favorited):
                return "Tap to \(favorited ? "remove from favorites" : "add to favorites")"
            case .scrollView,
                    .generalInformation,
                    .breweryType,
                    .locationInformation:
                return nil
            }
        }
    }
}
