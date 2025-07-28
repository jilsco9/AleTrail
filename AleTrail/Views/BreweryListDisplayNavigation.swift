//
//  BreweryNavigation.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/27/25.
//

import SwiftUI

struct BreweryListDisplayNavigation: View {
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
        BreweryListDisplayNavigation(settings: .preview)
    }
    .environment(appModel)
}
