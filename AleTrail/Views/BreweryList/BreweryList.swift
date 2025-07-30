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
            debugPrint("Unexpected display mode type: \(settings.breweryListDisplayMode). Resetting display mode to all.")
            settings.breweryListDisplayMode = BreweryListDisplayMode.all.rawValue
        }
        
        lastIDToInitiateLoad = nil
    }
    
    var body: some View {
        @Bindable var appModel = appModel
        List {
            ForEach(appModel.breweries) { brewery in
                NavigationLink(brewery.name) {
                    BreweryDetail(
                        brewery: brewery,
                        settings: settings
                    )
                }
                .accessibility(AccessibilityAttributes.BreweryList.breweryListItem(id: brewery.id))
                .onScrollVisibilityChange(threshold: 0.5) { isVisible in
                    if isVisible, brewery.id == appModel.lastLoadedBreweryID, brewery.id != lastIDToInitiateLoad {
                        lastIDToInitiateLoad = brewery.id
                        Task {
                            await updateBreweryList(displayMode: settings.breweryListDisplayMode, initialFetch: false)
                        }
                    }
                }
            }
            
            
            if appModel.loading {
                ProgressView()
                    .accessibility(AccessibilityAttributes.BreweryList.progressIndicator)
            } else if appModel.hasErrorOnPageLoad {
                VStack {
                    Text("An error occurred loading more breweries.")
                    Button("Try again") {
                        Task {
                            // TODO: - this is logic that I'd like to move to model, but I don't want to introduce
                            // another arg. But maybe loadingInitiationType (initialFetch/nextPage/loadRetry?)
                            // to differentiate?
                            appModel.allBreweriesHaveBeenLoaded = false
                            await updateBreweryList(displayMode: settings.breweryListDisplayMode, initialFetch: false)
                        }
                    }
                }
            }
        }
        .accessibilityElement(children: .contain)
        .accessibility(AccessibilityAttributes.BreweryList.list)
        .refreshable {
            Task {
                await updateBreweryList(displayMode: settings.breweryListDisplayMode, initialFetch: true)
            }
        }
        .overlay {
            if !appModel.loading,
                appModel.allBreweriesHaveBeenLoaded,
                appModel.breweries.isEmpty,
               let displayMode = BreweryListDisplayMode(rawValue: settings.breweryListDisplayMode) {
                    ContentUnavailableView {
                        Label("No Breweries", systemImage: displayMode.systemImage)
                    } description: {
                        Text(displayMode.noResultsMessage)
                    }
                    .accessibilityElement(children: .contain)
                    .accessibility(AccessibilityAttributes.BreweryList.noBreweriesView)
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
    .modelContainer(for: Settings.self, inMemory: true)
}
