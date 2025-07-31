//
//  SettingsTests.swift
//  AleTrailTests
//
//  Created by Jillian Scott on 7/30/25.
//

import SwiftData
import Testing
@testable import AleTrail

@MainActor
struct SettingsTests {
    
    @Test func addAndRemoveFavorite() async throws {
        let sharedModelContainer: ModelContainer = {
            let schema = Schema([
                Settings.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        
        let settings = Settings(favoriteBreweryIDs: [])
        
        let testFavorite = Brewery.previewEastCliff
        
        // Starting conditions
        #expect(settings.favoriteBreweryIDs.isEmpty)
        
        settings.addFavorite(id: testFavorite.id, modelContext: sharedModelContainer.mainContext)
        
        #expect(settings.favoriteBreweryIDs.count == 1)
        let favoriteID = try #require(settings.favoriteBreweryIDs.first)
        #expect(favoriteID == testFavorite.id)
        
        settings.removeFavorite(id: testFavorite.id, modelContext: sharedModelContainer.mainContext)
        
        #expect(settings.favoriteBreweryIDs.isEmpty)
    }
}
