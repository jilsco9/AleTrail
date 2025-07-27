//
//  BreweryList.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import SwiftUI

struct BreweryList: View {
    @Environment(AleTrailAppModel.self) private var appModel
    
    let userFavorites: Settings
    
    @State var selectedBrewery: Brewery?
    
    var body: some View {
        List(appModel.breweries) { brewery in
            NavigationLink(brewery.name) {
                BreweryDetail(
                    brewery: brewery,
                    userFavorites: userFavorites
                )
            }
        }
    }
}

#Preview {
    @Previewable @State var appModel = AleTrailAppModel.preview
    NavigationStack {
        BreweryList(userFavorites: .preview)
    }
    .environment(appModel)
}
