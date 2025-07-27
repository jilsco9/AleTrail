//
//  BreweryDetail.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import SwiftUI

struct BreweryDetail: View {
    let brewery: Brewery
    let userFavorites: Settings
    
    var isFavorite: Bool {
        userFavorites.ids.contains(brewery.id)
    }
    
    var body: some View {
        Text(brewery.name)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        isFavorite ? "Remove Favorite" : "Add Favorite",
                        systemImage: isFavorite ? "heart.fill" : "heart",
                        action: {
                            isFavorite ? userFavorites.removeFavorite(id: brewery.id) : userFavorites.addFavorite(id: brewery.id)
                        }
                    )
                }
            }
    }
}

#Preview {
    @Previewable @State var appModel = AleTrailAppModel.preview
    NavigationStack {
        BreweryDetail(
            brewery: Brewery.previewUnion,
            userFavorites: Settings.preview
        )
    }
    .environment(appModel)
}
