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
        
        let settings = Settings(favoriteBreweries: [])
        
        let testFavorite = Brewery.previewEastCliff
        
        // Starting conditions
        #expect(settings.favoriteBreweries.isEmpty)
        
        settings.addFavorite(id: testFavorite.id, name: testFavorite.name, modelContext: sharedModelContainer.mainContext)
        
        #expect(settings.favoriteBreweries.count == 1)
        let firstFavorite = try #require(settings.favoriteBreweries.first)
        #expect(firstFavorite.id == testFavorite.id)
        #expect(firstFavorite.name == testFavorite.name)
        
        settings.removeFavorite(id: testFavorite.id, modelContext: sharedModelContainer.mainContext)
        
        #expect(settings.favoriteBreweries.isEmpty)
    }
}
