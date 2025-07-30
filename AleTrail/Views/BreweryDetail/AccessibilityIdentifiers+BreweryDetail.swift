//
//  AccessibilityIdentifiers+BreweryDetail.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/28/25.
//

import Foundation

extension AccessibilityAttributes {
    enum BreweryDetail: Accessibility {
        case list
        case generalInformation
        case breweryType(String)
        case locationInformation
        case locationCoordinates
        case contactInformationPhone
        case contactInformationWebsite
        case favoriteButton(favorited: Bool)
        
        var screenID: String {
            "BreweryDetail"
        }
        
        var componentID: String {
            switch self {
            case .list:
                "list"
            case .generalInformation:
                "generalInformation"
            case .breweryType:
                "breweryType"
            case .locationInformation:
                "locationInformation"
            case .locationCoordinates:
                "locationCoordinates"
            case .contactInformationPhone:
                "contactInformationPhone"
            case .contactInformationWebsite:
                "contactInformationWebsite"
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
            case .list,
                    .generalInformation,
                    .locationInformation,
                    .contactInformationPhone,
                    .contactInformationWebsite,
                    .locationCoordinates:
                return nil
            }
        }
        
        var accessibilityHint: String? {
            switch self {
            case .favoriteButton(let favorited):
                return "Tap to \(favorited ? "remove from favorites" : "add to favorites")"
            case .list,
                    .generalInformation,
                    .breweryType,
                    .locationInformation,
                    .contactInformationPhone,
                    .contactInformationWebsite,
                    .locationCoordinates:
                return nil
            }
        }
    }
}
