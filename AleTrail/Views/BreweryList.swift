//
//  BreweryList.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import SwiftUI

struct BreweryList: View {
    @Environment(AleTrailAppModel.self) private var appModel
    
    let settings: Settings
    
    @State var selectedBrewery: Brewery?
    @State var lastIDToInitiateLoad: String?
        
    func updateBreweryList(displayMode: String, initialFetch: Bool) async {
        switch settings.breweryListDisplayMode {
        case BreweryListDisplayMode.all.rawValue:
            await appModel.getBreweryList(initialFetch: initialFetch)
        case BreweryListDisplayMode.favorites.rawValue:
            await appModel.getBreweriesByIDs(
                Array(settings.favoriteBreweryIDs),
                initialFetch: initialFetch
            )
        default:
            // TODO: - handle as error?
            debugPrint("Unexpected display mode type: \(settings.breweryListDisplayMode)")
        }
        
        lastIDToInitiateLoad = nil
    }
    
    var body: some View {
        @Bindable var appModel = appModel
                List(appModel.breweries) { brewery in
                    NavigationLink(brewery.name) {
                        BreweryDetail(
                            brewery: brewery,
                            userFavorites: settings
                        )
                    }
                    .onScrollVisibilityChange(threshold: 0.5) { isVisible in
                        if isVisible, brewery.id == appModel.lastLoadedBreweryID, brewery.id != lastIDToInitiateLoad {
                            lastIDToInitiateLoad = brewery.id
                            print("Last brewery ID is visible! \(brewery.id)")
                            Task {
                                await updateBreweryList(displayMode: settings.breweryListDisplayMode, initialFetch: false)
                            }
                        }
                        
                    }
//                    .task {
//                        guard !loading else { return }
//                        if brewery.id == appModel.lastLoadedBreweryID {
//                            await updateBreweryList(displayMode: settings.breweryListDisplayMode, initialFetch: false)
//                        }
//                    }
                    
                    if appModel.loading {
                        ProgressView()
                    }
                }
                
        .onChange(of: settings.breweryListDisplayMode, initial: true) {
            Task {
                await updateBreweryList(displayMode: settings.breweryListDisplayMode, initialFetch: true)
            }
        }
        .alert(isPresented: $appModel.hasBreweryServiceError, error: appModel.breweryServiceError) {}
    }
}

#Preview {
    @Previewable @State var appModel = AleTrailAppModel.preview
    NavigationStack {
        BreweryList(settings: .preview)
    }
    .environment(appModel)
}
