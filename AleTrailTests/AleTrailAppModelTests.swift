//
//  AleTrailAppModelTests.swift
//  AleTrailTests
//
//  Created by Jillian Scott on 7/30/25.
//

import Foundation
import Testing
@testable import AleTrail

// TODO: - Move out
struct TestError: Error {
    
}

@MainActor
struct AleTrailAppModelTests {
    
    // MARK: Get Brewery List
    // Initial fetch
    @Test("All Breweries - Initial Fetch")
    func initialBreweryFetch() async throws {
        let testModels = Brewery.previewList
        let breweryService = TestBreweryService()

        let appModel = AleTrailAppModel(
            breweryService: breweryService
        )
        
        // Starting conditions:
        #expect(appModel.breweries.isEmpty)
        #expect(appModel.allBreweriesHaveBeenLoaded == false)
        #expect(appModel.lastLoadedBreweryPage == 1)
        
        await breweryService.addResponse(.breweryList(.success(testModels)))
        await appModel.getBreweryList(initialFetch: true)
        
        #expect(appModel.breweries.count > 0)
        #expect(appModel.allBreweriesHaveBeenLoaded)
        #expect(appModel.lastLoadedBreweryPage == 1)
        
        await breweryService.addResponse(.breweryList(.success(testModels)))
        // Do another initial fetch to ensure page resets to 1
        await appModel.getBreweryList(initialFetch: true)
        
        #expect(appModel.breweries.count > 0)
        #expect(appModel.allBreweriesHaveBeenLoaded)
        #expect(appModel.lastLoadedBreweryPage == 1)
    }
    
    // Empty result
    @Test("All Breweries - Empty Brewery List")
    func fetchEmptyBreweryList() async throws {
        let testModels: [Brewery] = []
        let breweryService = TestBreweryService()

        let appModel = AleTrailAppModel(
            breweryService: breweryService
        )
        
        // Starting conditions:
        #expect(appModel.breweries.isEmpty)
        #expect(appModel.allBreweriesHaveBeenLoaded == false)
        #expect(appModel.lastLoadedBreweryPage == 1)
        
        await breweryService.addResponse(.breweryList(.success(testModels)))
        await appModel.getBreweryList(initialFetch: true)
        
        #expect(appModel.breweries.isEmpty)
        #expect(appModel.allBreweriesHaveBeenLoaded)
        #expect(appModel.lastLoadedBreweryPage == 1)
    }
    
    // Two full pages
    @Test("All Breweries - Two Full Brewery List Pages")
    func fetchTwoPagesOfBreweries() async throws {
        
        let testModelsPage1: [Brewery] = createUniqueBreweries(count: 50)
        let testModelsPage2: [Brewery] = createUniqueBreweries(count: 50)
        let testModelsPage3: [Brewery] = []
        
        let breweryService = TestBreweryService()

        let appModel = AleTrailAppModel(
            breweryService: breweryService
        )
        
        // Starting conditions
        #expect(appModel.breweries.isEmpty)
        #expect(appModel.allBreweriesHaveBeenLoaded == false)
        #expect(appModel.lastLoadedBreweryPage == 1)
        
        // First page fetch
        await breweryService.addResponse(.breweryList(.success(testModelsPage1)))
        await appModel.getBreweryList(initialFetch: true)
        
        #expect(appModel.breweries.count == 50)
        #expect(appModel.allBreweriesHaveBeenLoaded == false)
        #expect(appModel.lastLoadedBreweryPage == 1)
        
        // Second page fetch
        await breweryService.addResponse(.breweryList(.success(testModelsPage2)))
        await appModel.getBreweryList(initialFetch: false)
        
        #expect(appModel.breweries.count == 100)
        #expect(appModel.allBreweriesHaveBeenLoaded == false)
        #expect(appModel.lastLoadedBreweryPage == 2)
        
        // Third page fetch
        await breweryService.addResponse(.breweryList(.success(testModelsPage3)))
        await appModel.getBreweryList(initialFetch: false)
        
        #expect(appModel.breweries.count == 100)
        #expect(appModel.allBreweriesHaveBeenLoaded == true)
        #expect(appModel.lastLoadedBreweryPage == 3)
    }
    
    // One and a half pages
    @Test("All Breweries - One and a Half Brewery List Pages")
    func fetchPartialPageBreweries() async throws {
        
        let testModelsPage1: [Brewery] = createUniqueBreweries(count: 50)
        let testModelsPage2: [Brewery] = createUniqueBreweries(count: 25)
        
        let breweryService = TestBreweryService()

        let appModel = AleTrailAppModel(
            breweryService: breweryService
        )
        
        // Starting conditions:
        #expect(appModel.breweries.isEmpty)
        #expect(appModel.allBreweriesHaveBeenLoaded == false)
        #expect(appModel.lastLoadedBreweryPage == 1)
        
        await breweryService.addResponse(.breweryList(.success(testModelsPage1)))
        await appModel.getBreweryList(initialFetch: true)
        
        #expect(appModel.breweries.count == 50)
        #expect(appModel.allBreweriesHaveBeenLoaded == false)
        #expect(appModel.lastLoadedBreweryPage == 1)
        
        await breweryService.addResponse(.breweryList(.success(testModelsPage2)))
        
        await appModel.getBreweryList(initialFetch: false)
        
        #expect(appModel.breweries.count == 75)
        #expect(appModel.allBreweriesHaveBeenLoaded)
        #expect(appModel.lastLoadedBreweryPage == 2)
    }
    
    
    @Test("All Breweries - Initial Fetch Error")
    func initialFetchError() async throws {
        let breweryService = TestBreweryService()
        let testModels = Brewery.previewList

        let appModel = AleTrailAppModel(
            breweryService: breweryService
        )
        
        // Starting conditions:
        #expect(appModel.breweries.isEmpty)
        #expect(appModel.allBreweriesHaveBeenLoaded == false)
        #expect(appModel.lastLoadedBreweryPage == 1)
        
        // Failed fetch
        await breweryService.addResponse(.breweryList(.failure(.networkingError(.other(TestError())))))
        await appModel.getBreweryList(initialFetch: true)
        
        #expect(appModel.breweries.isEmpty)
        #expect(appModel.allBreweriesHaveBeenLoaded == true)
        #expect(appModel.lastLoadedBreweryPage == 1)
        #expect(appModel.hasErrorOnPageLoad == false)
        #expect(appModel.hasBreweryServiceError == true)
        #expect(appModel.breweryServiceError?.errorDescription == BreweryServiceError.networkingError(.other(TestError())).errorDescription)
        
        // Successful fetch - ensure states are reset
        await breweryService.addResponse(.breweryList(.success(testModels)))
        await appModel.getBreweryList(initialFetch: true)
        
        #expect(appModel.breweries.count > 0)
        #expect(appModel.allBreweriesHaveBeenLoaded)
        #expect(appModel.lastLoadedBreweryPage == 1)
        #expect(appModel.hasErrorOnPageLoad == false)
        #expect(appModel.hasBreweryServiceError == false)
        #expect(appModel.breweryServiceError == nil)
    }
    
    @Test("All Breweries - Error on Page Load")
    func errorOnPageLoad() async throws {
        let testModelsPage1: [Brewery] = createUniqueBreweries(count: 50)
        let testModelsPage2: [Brewery] = createUniqueBreweries(count: 50)
        
        let breweryService = TestBreweryService()

        let appModel = AleTrailAppModel(
            breweryService: breweryService
        )
        
        // Starting conditions
        #expect(appModel.breweries.isEmpty)
        #expect(appModel.allBreweriesHaveBeenLoaded == false)
        #expect(appModel.lastLoadedBreweryPage == 1)
        
        // Successful initial fetch
        await breweryService.addResponse(.breweryList(.success(testModelsPage1)))
        await appModel.getBreweryList(initialFetch: true)
        
        #expect(appModel.breweries.count == 50)
        #expect(appModel.allBreweriesHaveBeenLoaded == false)
        #expect(appModel.lastLoadedBreweryPage == 1)
        
        // Failure on second page
        await breweryService.addResponse(.breweryList(.failure(.networkingError(.other(TestError())))))
        await appModel.getBreweryList(initialFetch: false)
        
        #expect(appModel.breweries.count == 50)
        #expect(appModel.allBreweriesHaveBeenLoaded == true)
        #expect(appModel.lastLoadedBreweryPage == 1)
        #expect(appModel.hasErrorOnPageLoad == true)
        #expect(appModel.hasBreweryServiceError == true)
        #expect(appModel.breweryServiceError?.errorDescription == BreweryServiceError.networkingError(.other(TestError())).errorDescription)
        
        // Try again
        appModel.allBreweriesHaveBeenLoaded = false
        
        // Second page fetch
        await breweryService.addResponse(.breweryList(.success(testModelsPage2)))
        await appModel.getBreweryList(initialFetch: false)
        
        #expect(appModel.breweries.count == 100)
        #expect(appModel.allBreweriesHaveBeenLoaded == false)
        #expect(appModel.lastLoadedBreweryPage == 2)
        #expect(appModel.hasErrorOnPageLoad == false)
        #expect(appModel.hasBreweryServiceError == false)
        #expect(appModel.breweryServiceError?.errorDescription == nil)
    }
}

private extension AleTrailAppModelTests {
    func createUniqueBreweries(count: Int) -> [Brewery] {
        return (0..<count).map { _ in
            Brewery(
                id: UUID().uuidString,
                name: "Union Brewing",
                breweryType: "micro",
                address1: "622 S Rangeline Rd Ste Q",
                address2: nil,
                address3: nil,
                city: "Carmel",
                stateProvince: "Indiana",
                postalCode: "46032-2152",
                country: "United States",
                longitude: -86.129922,
                latitude: 39.966276,
                phone: "3175644466",
                websiteUrl: "http://www.unionbrewingco.com",
                state: "Indiana",
                street: "622 S Rangeline Rd Ste Q"
            )
        }
    }
}
