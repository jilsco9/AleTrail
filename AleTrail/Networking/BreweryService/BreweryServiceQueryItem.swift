//
//  BreweryServiceQueryItem.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/24/25.
//

import Foundation

enum BreweryServiceQueryItem {
    case perPage(Int)
    case page(Int)
    // Note: Funcitonality cut for scope
    case city(String)
    case ids([String])
    
    var name: String {
        switch self {
        case .perPage:
            "per_page"
        case .page:
            "page"
        case .city:
            "by_city"
        case .ids:
            "by_ids"
        }
    }
    
    var value: String {
        switch self {
        case .perPage(let count):
            String(count)
        case .page(let page):
            String(page)
        case .city(let name):
            name
        case .ids(let ids):
            ids.joined(separator: ",")
        }
    }
    
    var queryItem: URLQueryItem {
        URLQueryItem(name: name, value: value)
    }
}
