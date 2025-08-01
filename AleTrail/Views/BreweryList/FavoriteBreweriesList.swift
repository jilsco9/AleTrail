//
//  FavoriteBreweriesList.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/31/25.
//

import SwiftUI

struct FavoriteBreweriesList: View {
    let settings: Settings
        
    var body: some View {
        List {
            ForEach(settings.favoriteBreweries) { brewery in
                NavigationLink(brewery.name) {
                    BreweryDetailsLoadingView(
                        id: brewery.id,
                        settings: settings
                    )
                }
                .accessibility(AccessibilityAttributes.BreweryList.breweryListItem(id: brewery.id))
            }
        }
        .accessibilityElement(children: .contain)
        .accessibility(AccessibilityAttributes.BreweryList.list)
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
    }
}

#Preview {
    FavoriteBreweriesList(settings: Settings.preview)
}
