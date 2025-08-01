//
//  BreweryServiceEndpoint.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/24/25.
//

import Foundation

enum BreweryServiceEndpoint {
    static let basePath: String = "https://api.openbrewerydb.org/v1/breweries"
    static let perPage: Int = 50
    static let maxIDs: Int = 6
    
    case list(page: Int)
    // Note: Funcitonality cut for scope
    case search(city: String, page: Int)
    case favorites(ids: [String], page: Int)
    case singleBrewery(id: String)
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .list(let page):
            [
                BreweryServiceQueryItem.page(page).queryItem,
                BreweryServiceQueryItem.perPage(Self.perPage).queryItem
            ]
        // Note: Funcitonality cut for scope
        case .search(let city, let page):
            [
                BreweryServiceQueryItem.city(city).queryItem,
                BreweryServiceQueryItem.page(page).queryItem,
                BreweryServiceQueryItem.perPage(Self.perPage).queryItem
            ]
        case .favorites(let ids, let page):
            [
                BreweryServiceQueryItem.ids(ids).queryItem,
                BreweryServiceQueryItem.page(page).queryItem,
                BreweryServiceQueryItem.perPage(Self.perPage).queryItem
            ]
        case .singleBrewery:
            []
        }
    }
    
    var appendedPath: String? {
        switch self {
        case .singleBrewery(let id):
            "/\(id)"
            
        case .list,
                .search,
                .favorites:
            nil
        }
    }
    
    func getURLComponents() throws(BreweryServiceError) -> URLComponents {
        guard var urlComponents = URLComponents(string: Self.basePath) else {
            throw .invalidEndpoint
        }
        
        if let appendedPath {
            urlComponents.path += appendedPath
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents
    }
    
    func getURL() throws(BreweryServiceError) -> URL {
        guard let url = try getURLComponents().url else {
            throw .invalidEndpoint
        }
        
        return url
    }
}
