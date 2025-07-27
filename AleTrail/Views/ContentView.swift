//
//  ContentView.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/23/25.
//

import SwiftUI
import SwiftData

//enum AppState {
//    case loaded
//    case creatingSettingsModel
//    case performingInitialLoad
//    
//    var loadingMessage: String? {
//        switch self {
//        case .loaded:
//            nil
//        case .creatingSettingsModel:
//            "Initializing app..."
//        case .performingInitialLoad:
//            "Fetching breweries..."
//        }
//    }
//}

struct ContentView: View {
    @Environment(AleTrailAppModel.self) private var appModel
    @Environment(\.modelContext) private var modelContext
    @Query private var settings: [Settings]
        
    func retrieveOrCreateFavoriteBreweries() {
        if settings.first == nil {
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
                    ToolbarItemGroup(placement: .bottomBar) {
                        BreweryListDisplayModeToolbarGroup(favoriteBreweries: favoriteBreweries)
                    }
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
