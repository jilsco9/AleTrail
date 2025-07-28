//
//  BreweryListDisplayModeNavigation.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/27/25.
//

import SwiftUI

struct BreweryListDisplayModeNavigation: View {
    let settings: Settings
    
    var body: some View {
        BreweryList(
            settings: settings
        )
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                BreweryListDisplayModeButtonContainer(settings: settings)
            }
        }
        .navigationTitle("Breweries")
    }
}

#Preview {
    @Previewable @State var appModel = AleTrailAppModel.preview
    NavigationStack {
        BreweryListDisplayModeNavigation(settings: .preview)
    }
    .environment(appModel)
}
