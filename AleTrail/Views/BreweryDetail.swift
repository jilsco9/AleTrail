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
    
    var body: some View {
        Text(brewery.name)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        isFavorite ? "Remove Favorite" : "Add Favorite",
                        systemImage: isFavorite ? "heart.fill" : "heart",
                        action: {
                            isFavorite ? settings.removeFavorite(id: brewery.id) : settings.addFavorite(id: brewery.id)
                        }
                    )
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
