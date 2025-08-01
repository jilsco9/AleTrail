//
//  FavoriteBreweriesList.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/31/25.
//

import SwiftUI

struct FavoriteBreweryDetail: View {
    @Environment(AleTrailAppModel.self) private var appModel
    @State var selectedBrewery: Brewery?
    let id: String
    let settings: Settings
    
    var body: some View {
        if let selectedBrewery {
            BreweryDetail(
                brewery: selectedBrewery,
                settings: settings
            )
        } else {
            ProgressView("Loading details...")
                .task {
                    do {
                        let brewery = try await appModel.getBreweryByID(id)
                        selectedBrewery = brewery
                    } catch {
                        debugPrint("Error") // TODO: - Handle
                    }
                }
        }
    }
}

struct FavoriteBreweriesList: View {
//    @Environment(AleTrailAppModel.self) private var appModel
    
    let settings: Settings
    
    @State var selectedBrewery: Brewery?
    @State var lastIDToInitiateLoad: String?
    
    var body: some View {
        List {
            ForEach(settings.favoriteBreweries) { brewery in
                NavigationLink(brewery.name) {
                    // TODO: - Load brewery
                    FavoriteBreweryDetail(
                        id: brewery.id,
                        settings: settings
                    )
                }
                .accessibility(AccessibilityAttributes.BreweryList.breweryListItem(id: brewery.id))
            }
            
            
//            if appModel.loading {
//                ProgressView()
//                    .accessibility(AccessibilityAttributes.BreweryList.progressIndicator)
//            } else if appModel.hasErrorOnPageLoad {
//                VStack {
//                    Text("An error occurred loading more breweries.")
//                    Button("Try again") {
//                        Task {
//                            appModel.allBreweriesHaveBeenLoaded = false
//                            await updateBreweryList(displayMode: settings.breweryListDisplayMode, initialFetch: false)
//                        }
//                    }
//                }
//            }
        }
        .navigationTitle("Favorite Breweries")
        .accessibilityElement(children: .contain)
        .accessibility(AccessibilityAttributes.BreweryList.list)
//        .refreshable {
//            Task {
//                await updateBreweryList(displayMode: settings.breweryListDisplayMode, initialFetch: true)
//            }
//        }
        .overlay {
            if settings.favoriteBreweries.isEmpty {
                ContentUnavailableView {
                    Label("No Breweries", systemImage: BreweryListDisplayMode.favorites.systemImage)
                } description: {
                    Text(BreweryListDisplayMode.favorites.noResultsMessage)
                }
                .accessibilityElement(children: .contain)
                .accessibility(AccessibilityAttributes.BreweryList.noBreweriesView)
            }
        }
//        .alert(isPresented: $appModel.hasBreweryServiceError, error: appModel.breweryServiceError, actions: { _ in
//            Button("OK") {
//                appModel.breweryServiceError = nil
//            }
//        }, message: { error in
//            Text(error.recoverySuggestion ?? "Please try again.")
//        })
    }
}

#Preview {
    FavoriteBreweriesList(settings: Settings.preview)
}
