//
//  TestBreweryService.swift
//  AleTrail
//
//  Created by Jillian Scott on 8/2/25.
//

import Foundation

// TODO: - Move to tests

actor TestBreweryService: BreweryService {
    var responses: [BreweryResponse] = []
    
    enum BreweryResponse {
        case breweryList(Result<[Brewery], BreweryServiceError>)
        case brewery(Result<Brewery, BreweryServiceError>)
        
        var typeID: String {
            switch self {
            case .breweryList:
                "breweryList"
            case .brewery:
                "brewery"
            }
        }
    }
    
    func addResponse(_ responseExpectation: BreweryResponse) {
        responses.append(responseExpectation)
    }
    
    func resetResponses() {
        responses.removeAll()
    }
    
    func getBreweries(byIDs ids: [String], page: Int) async throws(BreweryServiceError) -> [Brewery] {
        if let index = responses.firstIndex(where: { $0.typeID == "breweryList" }) {
            let response = responses[index]
            if case .breweryList(let result) = response {
                switch result {
                case .failure(let error):
                    responses.remove(at: index)
                    throw error
                case .success(let value):
                    responses.remove(at: index)
                    return value
                }
            } else {
                // TODO: - Clarify
                fatalError("Did not find a response of this type. Did you forget to call addResponse?")
            }
        } else {
            fatalError("Did not find a response of this type. Did you forget to call addResponse?")
        }
    }
    
    func getBreweries(page: Int) async throws(BreweryServiceError) -> [Brewery] {
        if let index = responses.firstIndex(where: { $0.typeID == "breweryList" }) {
            let response = responses[index]
            if case .breweryList(let result) = response {
                switch result {
                case .failure(let error):
                    responses.remove(at: index)
                    throw error
                case .success(let value):
                    responses.remove(at: index)
                    return value
                }
            } else {
                // TODO: - Clarify
                fatalError("Did not find a response of this type. Did you forget to call addResponse?")
            }
        } else {
            fatalError("Did not find a response of this type. Did you forget to call addResponse?")
        }
    }
    
    // Note: Functionality cut for scope
    func getBreweries(byCity city: String, page: Int) async throws(BreweryServiceError) -> [Brewery] {
        if let index = responses.firstIndex(where: { $0.typeID == "breweryList" }) {
            let response = responses[index]
            if case .breweryList(let result) = response {
                switch result {
                case .failure(let error):
                    responses.remove(at: index)
                    throw error
                case .success(let value):
                    responses.remove(at: index)
                    return value
                }
            } else {
                // TODO: - Clarify
                fatalError("Did not find a response of this type. Did you forget to call addResponse?")
            }
        } else {
            fatalError("Did not find a response of this type. Did you forget to call addResponse?")
        }
    }
    
    func getBrewery(id: String) async throws(BreweryServiceError) -> Brewery {
        if let index = responses.firstIndex(where: { $0.typeID == "brewery" }) {
            let response = responses[index]
            if case .brewery(let result) = response {
                switch result {
                case .failure(let error):
                    responses.remove(at: index)
                    throw error
                case .success(let value):
                    responses.remove(at: index)
                    return value
                }
            } else {
                // TODO: - Clarify
                fatalError("Did not find a response of this type. Did you forget to call addResponse?")
            }
        } else {
            fatalError("Did not find a response of this type. Did you forget to call addResponse?")
        }
    }
}

