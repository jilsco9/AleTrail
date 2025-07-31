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
    @Query private var settings: [Settings]
        
    func createSettingsIfNeeded() {
        if settings.first == nil {
            debugPrint("No previous settings found. Creating settings model.")
            let newFavoriteBreweries = Settings(favoriteBreweryIDs: [])
            modelContext.insert(newFavoriteBreweries)
        }
    }
    
    var body: some View {
        NavigationStack {
            if let loadedSettings = settings.first {
                BreweryListDisplayModeNavigation(settings: loadedSettings)
            } else {
                ProgressView("Initializing app...")
            }
        }
        .onAppear {
            createSettingsIfNeeded()
        }
    }
}

#Preview {
    @Previewable @State var appModel = AleTrailAppModel.preview
    ContentView()
        .modelContainer(for: Settings.self, inMemory: true)
        .environment(appModel)
}
