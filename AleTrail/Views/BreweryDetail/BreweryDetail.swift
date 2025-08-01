//
//  BreweryDetail.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import SwiftUI
import SwiftData

struct BreweryDetail: View {
    @Environment(\.modelContext) private var modelContext
    
    let brewery: Brewery
    let settings: Settings
    
    var isFavorite: Bool {
        settings.containsFavoriteBrewery(brewery)
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
                Section {
                    VStack(alignment: .leading) {
                        Text(brewery.name)
                            .font(.largeTitle)
                            .fixedSize(horizontal: false, vertical: true)
                        
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
                    .accessibilityIdentifier(AccessibilityAttributes.BreweryDetail.generalInformation.id)
                    
                    if let breweryType = BreweryType(rawValue: brewery.breweryType ?? "") {
                        BreweryTypeView(breweryType: breweryType)
                            .accessibilityElement(children: .combine)
                            .accessibility(AccessibilityAttributes.BreweryDetail.breweryType(breweryType.title))
                    }
                }
                
                Section("Contact") {
                    BreweryContactView(brewery: brewery)
                }
                
                Section("Location") {
                    BreweryLocationView(brewery: brewery)
                }
                

            }
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier(AccessibilityAttributes.BreweryDetail.list.id)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(
                    isFavorite ? "Remove Favorite" : "Add Favorite",
                    systemImage: isFavorite ? "heart.fill" : "heart",
                    action: {
                        isFavorite ? settings.removeFavorite(
                            id: brewery.id, modelContext: modelContext
                        ) : settings.addFavorite(
                            id: brewery.id,
                            name: brewery.name,
                            modelContext: modelContext
                        )
                    }
                )
                .tint(.accent)
                .accessibility(AccessibilityAttributes.BreweryDetail.favoriteButton(favorited: isFavorite))
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
    .modelContainer(for: Settings.self, inMemory: true)
}
