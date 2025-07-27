//
//  AleTrailApp.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/23/25.
//

import SwiftUI
import SwiftData

@main
struct AleTrailApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Settings.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State var appModel: AleTrailAppModel = {
        AleTrailAppModel(breweryService: AleTrailBreweryService())
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .environment(appModel)
    }
}
