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
                .accessibility(
                    mode.getAccessibility(
                        selected: settings.breweryListDisplayMode == mode.rawValue
                    )
                )
            }
        }
        .controlSize(.large)
    }
}

fileprivate extension BreweryListDisplayMode {
    func getAccessibility(selected: Bool) -> Accessibility {
        switch self {
        case .all:
            AccessibilityAttributes.BreweryList.allBreweriesButton(selected: selected)
        case .favorites:
            AccessibilityAttributes.BreweryList.favoritesButton(selected: selected)
        }
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
