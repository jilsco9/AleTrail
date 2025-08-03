//
//  AllBreweriesList.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/31/25.
//

import SwiftUI
import SwiftData

struct AllBreweriesList: View {
    @Environment(AleTrailAppModel.self) private var appModel
    
    let settings: Settings
    
    @State var lastIDToInitiateLoad: String?
    
    func updateBreweryList(initialFetch: Bool) async {
        await appModel.getBreweryList(initialFetch: initialFetch)
        
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
                            await updateBreweryList(initialFetch: false)
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
                            await appModel.retryFailedPageFetch()
                            lastIDToInitiateLoad = nil
                        }
                    }
                }
            }
        }
        .accessibilityElement(children: .contain)
        .accessibility(AccessibilityAttributes.BreweryList.list)
        .task {
            if appModel.breweries.isEmpty {
                await updateBreweryList(initialFetch: true)
            }
        }
        .refreshable {
            Task {
                await updateBreweryList(initialFetch: true)
            }
        }
        .overlay {
            if !appModel.loading,
                appModel.allBreweriesHaveBeenLoaded,
               appModel.breweries.isEmpty {
                ContentUnavailableView {
                    Label("No Breweries", systemImage: BreweryListDisplayMode.all.systemImage)
                } description: {
                    Text(BreweryListDisplayMode.all.noResultsMessage)
                }
                .accessibilityElement(children: .contain)
                .accessibility(AccessibilityAttributes.BreweryList.noBreweriesView)
            }
        }
        .alert(isPresented: $appModel.hasBreweryServiceError, error: appModel.breweryServiceError, actions: { _ in
            Button("OK") {
                /// Default dismiss functionality
            }
        }, message: { error in
            Text(error.recoverySuggestion ?? "Please try again.")
        })
    }
}

#Preview {
    @Previewable @State var appModel = AleTrailAppModel.preview
    NavigationStack {
        AllBreweriesList(settings: .preview)
    }
    .environment(appModel)
    .modelContainer(for: Settings.self, inMemory: true)
}
