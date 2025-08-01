//
//  BreweryListNavigation.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/27/25.
//

import SwiftUI

struct BreweryListNavigation: View {
    let settings: Settings
    
    var body: some View {
        @Bindable var settings = settings
        TabView(selection: $settings.breweryListDisplayMode) {
            Tab(
                BreweryListDisplayMode.all.navigationTitle,
                systemImage: BreweryListDisplayMode.all.systemImage,
                value: BreweryListDisplayMode.all.rawValue
            ) {
                NavigationStack {
                    AllBreweriesList(settings: settings)
                        .navigationTitle(BreweryListDisplayMode.all.navigationTitle)
                }
            }
            
            Tab(
                BreweryListDisplayMode.favorites.navigationTitle,
                systemImage: BreweryListDisplayMode.favorites.systemImage,
                value: BreweryListDisplayMode.favorites.rawValue
            ) {
                NavigationStack {
                    FavoriteBreweriesList(settings: settings)
                        .navigationTitle(BreweryListDisplayMode.favorites.navigationTitle)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var appModel = AleTrailAppModel.preview
    NavigationStack {
        BreweryListNavigation(settings: .preview)
    }
    .environment(appModel)
}
