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
    @Query private var favorites: [Settings]
    
    @State var favoriteBreweries: Settings?
        
    func retrieveOrCreateFavoriteBreweries() {
        if let favoriteBreweries = favorites.first {
            debugPrint("Found existing Settings model.")
            self.favoriteBreweries = favoriteBreweries
            appModel.setFavoriteIDs(ids: Array(favoriteBreweries.ids))
        } else {
            debugPrint("No existing Settings model found. Creating one...")
            let newFavoriteBreweries = Settings(ids: [])
            modelContext.insert(newFavoriteBreweries)
            self.favoriteBreweries = newFavoriteBreweries
        }
    }
    
    var body: some View {
        Group {
            if let favoriteBreweries {
                @Bindable var appModel = appModel
                TabView(selection: $appModel.displayMode) {
                    ForEach(ListDisplayMode.allCases) { mode in
                        Tab(mode.title, systemImage: mode.systemImage, value: mode) {
                            NavigationStack {
                                BreweryList(
                                    userFavorites: favoriteBreweries,
                                )
                                .navigationTitle("Breweries")
                            }
                        }
                    }
                }
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
