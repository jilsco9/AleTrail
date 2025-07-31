//
//  MockBreweryService.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import Foundation

actor MockBreweryService: BreweryService {
    var breweryList: [Brewery]
    
    init(breweryList: [Brewery]) {
        self.breweryList = breweryList
    }
    
    func updateBreweryList(_ breweryList: [Brewery]) {
        self.breweryList = breweryList
    }
    
    func getBreweries(byIDs ids: [String], page: Int) async throws(BreweryServiceError) -> [Brewery] {
        return breweryList.filter { ids.contains($0.id) }
    }
    
    func getBreweries(page: Int) async throws(BreweryServiceError) -> [Brewery] {
        return breweryList
    }
    
    // Note: Functionality cut for scope
    func getBreweries(byCity city: String, page: Int) async throws(BreweryServiceError) -> [Brewery] {
        return breweryList.filter { brewery in
            brewery.city?.lowercased().contains(city.lowercased()) ?? false
        }
    }
}
