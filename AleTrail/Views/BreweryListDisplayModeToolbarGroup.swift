//
//  BreweryListDisplayModeToolbarGroup.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/27/25.
//

import SwiftUI

struct BreweryListDisplayModeToolbarGroup: View {
    let favoriteBreweries: Settings
    
    var body: some View {
        ToolbarItemGroup(placement: .bottomBar) {
            GlassEffectContainer {
                Button(BreweryListDisplayMode.all.title, systemImage: BreweryListDisplayMode.all.systemImage) {
                    withAnimation {
                        favoriteBreweries.breweryListDisplayMode = BreweryListDisplayMode.all.rawValue
                    }
                }
                .tint(favoriteBreweries.breweryListDisplayMode == BreweryListDisplayMode.all.rawValue ? .purple : .none)
                .buttonStyle(.bordered)
                
                Button(BreweryListDisplayMode.favorites.title, systemImage: BreweryListDisplayMode.favorites.systemImage) {
                    withAnimation {
                        favoriteBreweries.breweryListDisplayMode = BreweryListDisplayMode.favorites.rawValue
                    }
                    
                }
                .tint(favoriteBreweries.breweryListDisplayMode == BreweryListDisplayMode.favorites.rawValue ? .purple : .none)
                .buttonStyle(.bordered)
            }
            .controlSize(.large)
        }
    }
}

#Preview {
    BreweryListDisplayModeToolbarGroup()
}
