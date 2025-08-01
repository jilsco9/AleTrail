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
    // Functionality cut for scope
    case search(city: String, page: Int)
    case getBrewery(id: String)
    
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
        case .getBrewery:
            []
        }
    }
    
    var appendedPath: String? {
        switch self {
        case .getBrewery(let id):
            return "/\(id)"
            
        case .list,
                .search:
            return nil
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
