//
//  BreweryDetail.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import SwiftUI

struct BreweryDetail: View {
    let brewery: Brewery
    let settings: Settings
    
    var isFavorite: Bool {
        settings.favoriteBreweryIDs.contains(brewery.id)
    }
    
    var locationSummaryComponents: [String] {
        var components: [String] = []
        
        if let city = brewery.city {
            components.append(city)
        }
        
        if let stateProvince = brewery.stateProvince ?? brewery.state {
            components.append(stateProvince)
        }
        
        if let country = brewery.country {
            components.append(country)
        }
        
        return components
    }
    
    var body: some View {
        VStack {
            List {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text(brewery.name)
                            .font(.largeTitle)
                        
                        HStack(spacing: 10) {
                            ForEach(locationSummaryComponents, id: \.self) { component in
                                Text(component)
                                if component != locationSummaryComponents.last {
                                    Divider()
                                }
                            }
                        }
                    }
                    .font(.caption)
                    .padding(.bottom, 5)
                    .accessibilityElement(children: .combine)
                    .accessibilityIdentifier(AccessibilityIdentifiers.BreweryDetail.generalInformation.id)
                    
                    Divider()
                        .padding(10)
                    
                    BreweryTypeView(breweryTypeTitle: brewery.breweryType)
                        .accessibilityElement(children: .combine)
                        .accessibility(AccessibilityIdentifiers.BreweryDetail.breweryType(brewery.breweryType ?? "Unknown"))
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(
                    isFavorite ? "Remove Favorite" : "Add Favorite",
                    systemImage: isFavorite ? "heart.fill" : "heart",
                    action: {
                        isFavorite ? settings.removeFavorite(id: brewery.id) : settings.addFavorite(id: brewery.id)
                    }
                )
                .tint(.accent)
                .accessibility(AccessibilityIdentifiers.BreweryDetail.favoriteButton(favorited: isFavorite))
            }
        }
    }
}

#Preview {
    NavigationStack {
        BreweryDetail(
            brewery: Brewery.previewUnion,
            settings: Settings.preview
        )
    }
}
