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
            Tab(value: BreweryListDisplayMode.all.rawValue, content: {
                NavigationStack {
                    AllBreweriesList(settings: settings)
                        .navigationTitle(BreweryListDisplayMode.all.navigationTitle)
                }
            }, label: {
                Label(
                    BreweryListDisplayMode.all.navigationTitle,
                    systemImage: BreweryListDisplayMode.all.systemImage
                )
            })
            
            Tab(value: BreweryListDisplayMode.favorites.rawValue, content: {
                NavigationStack {
                    FavoriteBreweriesList(settings: settings)
                        .navigationTitle(BreweryListDisplayMode.favorites.navigationTitle)
                }
            }, label: {
                Label(
                    BreweryListDisplayMode.favorites.navigationTitle,
                    systemImage: BreweryListDisplayMode.favorites.systemImage
                )
            })
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
