//
//  ContentView.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/23/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(AleTrailAppModel.self) private var appModel
    @Environment(\.modelContext) private var modelContext
    @Query private var settings: [Settings]
    
    func retrieveOrCreateFavoriteBreweries() {
        if let _ = settings.first {
            debugPrint("Found existing Settings model.")
        } else {
            debugPrint("No existing Settings model found. Creating one...")
            let newFavoriteBreweries = Settings(ids: [])
            modelContext.insert(newFavoriteBreweries)
        }
    }
    
    var body: some View {
        NavigationStack {
            if let favoriteBreweries = settings.first {
                BreweryList(
                    settings: favoriteBreweries
                )
                .toolbar {
                    BreweryListDisplayModeToolbarGroup(favoriteBreweries: favoriteBreweries)
                }
                .navigationTitle("Breweries")
            } else {
                // TODO: - Update...
                ProgressView("Loading app...")
            }
        }
        .onAppear {
            retrieveOrCreateFavoriteBreweries()
        }
    }
}

#Preview {
    @Previewable @State var appModel = AleTrailAppModel(breweryService: MockBreweryService())
    ContentView()
        .modelContainer(for: Settings.self, inMemory: true)
        .environment(appModel)
}
