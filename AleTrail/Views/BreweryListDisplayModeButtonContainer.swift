//
//  BreweryListDisplayModeButtonContainer.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/27/25.
//

import SwiftUI

struct BreweryListDisplayModeButtonContainer: View {
    let settings: Settings
    
    var body: some View {
        GlassEffectContainer {
            ForEach(BreweryListDisplayMode.allCases) { mode in
                Button(mode.title, systemImage: mode.systemImage) {
                    withAnimation {
                        settings.breweryListDisplayMode = mode.rawValue
                    }
                }
                .tint(settings.breweryListDisplayMode == mode.rawValue ? .accent : .none)
                .buttonStyle(.bordered)
            }
        }
        .controlSize(.large)
    }
}

#Preview {
    NavigationStack {
        Text("")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    BreweryListDisplayModeButtonContainer(settings: .preview)
                }
            }
    }
}
