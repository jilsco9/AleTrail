//
//  BreweryType.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/27/25.
//

import Foundation

/// Descriptions from https://www.openbrewerydb.org/documentation#list-breweries
enum BreweryType: String {
    case micro
    case nano
    case regional
    case brewpub
    case large
    case planning
    case bar
    case contract
    case proprietor
    case closed
    
    var title: String {
        rawValue.capitalized
    }
    
    var description: String {
        switch self {
        case .micro:
            "Most craft breweries. For example, Samual Adams is still considered a micro brewery."
        case .nano:
            "An extremely small brewery which typically only distributes locally."
        case .regional:
            "A regional location of an expanded brewery. Ex. Sierra Nevada’s Asheville, NC location."
        case .brewpub:
            "A beer-focused restaurant or restaurant/bar with a brewery on-premise."
        case .large:
            "A very large brewery. Likely not for visitors. Ex. Miller-Coors. (deprecated)"
        case .planning:
            "A brewery in planning or not yet opened to the public."
        case .bar:
            "A bar. No brewery equipment on premise. (deprecated)"
        case .contract:
            "A brewery that uses another brewery’s equipment."
        case .proprietor:
            "Similar to contract brewing but refers more to a brewery incubator."
        case .closed:
            "A location which has been closed."
        }
    }
    
    var systemImage: String {
        switch self {
        case .micro:
            "mappin.circle"
        case .nano:
            "pin.circle"
        case .regional:
            "mappin.and.ellipse.circle"
        case .brewpub:
            "fork.knife.circle"
        case .large:
            "house.lodge.circle"
        case .planning:
            "hammer.circle"
        case .bar:
            "storefront.circle"
        case .contract:
            "arrow.left.arrow.right.circle"
        case .proprietor:
            "briefcase.circle"
        case .closed:
            "xmark.circle"
        }
    }
}
