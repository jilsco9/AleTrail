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
    
    @State var breweryServiceErrorIsPresented: Bool = false
    @State var breweryServiceError: BreweryServiceError?
    
    func updateBreweryList(displayMode: String) async {
        do {
            switch settings.breweryListDisplayMode {
            case BreweryListDisplayMode.all.rawValue:
                try await appModel.getBreweryList(initialFetch: true)
            case BreweryListDisplayMode.favorites.rawValue:
                try await appModel.getBreweriesByIDs(Array(settings.favoriteBreweryIDs), initialFetch: true)
            default:
                // TODO: - handle as error?
                debugPrint("Unexpected display mode type: \(settings.breweryListDisplayMode)")
            }
        } catch {
            debugPrint("Error fetching brewery list: \(error)")
            breweryServiceError = error
            breweryServiceErrorIsPresented = true
        }
    }
    
    var body: some View {
        List(appModel.breweries) { brewery in
            NavigationLink(brewery.name) {
                BreweryDetail(
                    brewery: brewery,
                    userFavorites: settings
                )
            }
        }
        .onChange(of: settings.breweryListDisplayMode, initial: true) {
            Task {
                await updateBreweryList(displayMode: settings.breweryListDisplayMode)
            }
        }
        .alert(isPresented: $breweryServiceErrorIsPresented, error: breweryServiceError) {}
    }
}

#Preview {
    @Previewable @State var appModel = AleTrailAppModel.preview
    NavigationStack {
        BreweryList(settings: .preview)
    }
    .environment(appModel)
}
