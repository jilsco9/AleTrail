//
//  BreweryList.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import SwiftUI
import SwiftData

struct BreweryList: View {
    @Environment(AleTrailAppModel.self) private var appModel
    
    let settings: Settings
    
    @State var selectedBrewery: Brewery?
    @State var lastIDToInitiateLoad: String?
    
    // TODO: - Not needed if we convert this to
    // use tab view.
    var listMode: BreweryListDisplayMode {
        if let breweryListDisplayMode = BreweryListDisplayMode(rawValue: settings.breweryListDisplayMode) {
            return breweryListDisplayMode
        } else {
            debugPrint("Got an unexpected list display mode value from settings.")
            debugPrint("Resetting display mode to .all")
            let allBreweriesMode = BreweryListDisplayMode.all
            settings.breweryListDisplayMode = allBreweriesMode.rawValue
            return allBreweriesMode
        }
    }
    
    var body: some View {
        switch listMode {
        case .all:
            AllBreweriesList(settings: settings)
        case .favorites:
            FavoriteBreweriesList(settings: settings)
        }
    }
}

#Preview {
    @Previewable @State var appModel = AleTrailAppModel.preview
    NavigationStack {
        BreweryList(settings: .preview)
    }
    .environment(appModel)
    .modelContainer(for: Settings.self, inMemory: true)
}
