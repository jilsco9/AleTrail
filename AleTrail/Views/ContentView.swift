//
//  ContentView.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/23/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoriteBreweries]
    
    @State var favoriteBreweries: FavoriteBreweries?
    
    @State var displayMode: ListDisplayMode = .all
    
    enum ListDisplayMode: String, CaseIterable {
        case all
        case favorites
        
        var title: String {
            rawValue.capitalized
        }
    }
    
    func retrieveOrCreateFavoriteBreweries() {
        if let favoriteBreweries = favorites.first {
            debugPrint("Found existing FavoriteBreweries model.")
            self.favoriteBreweries = favoriteBreweries
        } else {
            debugPrint("No existing FavoriteBreweries model found. Creating one...")
            let newFavoriteBreweries = FavoriteBreweries(ids: [])
            modelContext.insert(newFavoriteBreweries)
            self.favoriteBreweries = newFavoriteBreweries
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if let favoriteBreweries {
                    BreweryList(userFavorites: favoriteBreweries, displayMode: displayMode)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Menu {
                                    Picker("Display", selection: $displayMode) {
                                        ForEach(ListDisplayMode.allCases, id: \.self) { mode in
                                            Text(mode.title)
                                        }
                                    }
                                } label: {
                                    Label("Filter", systemImage: "line.3.horizontal.decrease")
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
}

#Preview {
    @Previewable @State var appModel = AleTrailAppModel(breweryService: MockBreweryService())
    ContentView()
        .modelContainer(for: FavoriteBreweries.self, inMemory: true)
        .environment(appModel)
}
