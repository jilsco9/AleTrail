//
//  BreweryList.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import SwiftUI

struct BreweryList: View {
    @Environment(AleTrailAppModel.self) private var appModel
    
    let userFavorites: FavoriteBreweries
    let displayMode: ContentView.ListDisplayMode
    
    @State var selectedBrewery: Brewery?
    
    // TODO: - Move this to data aggregate model
    func updateBreweryList() async {
        do {
            switch displayMode {
            case .all:
                try await appModel.getBreweryList(initialFetch: true)
            case .favorites:
                try await appModel.getBreweriesByIDs(Array(userFavorites.ids), initialFetch: true)
            }
        } catch {
            // TODO: - add error handling
            debugPrint("Error fetching breweries: \(error)")
        }
    }
    
    var body: some View {
        // Maybe modernize this a bit? There must be a better pattern?
//        Picker("List Type", selection: $selectedTab) {
//            ForEach(BreweryListType.allCases) { listType in
//                Text(listType.title)
//            }
//        }
//        .pickerStyle(.segmented)
//        .padding([.horizontal, .top])
        List(appModel.breweries) { brewery in
            NavigationLink(brewery.name) {
                BreweryDetail(
                    brewery: brewery,
                    userFavorites: userFavorites
                )
            }
        }
        .navigationTitle("Breweries")
        .task {
            await updateBreweryList()
        }
    }
}

#Preview {
    @Previewable @State var appModel = AleTrailAppModel.preview
    NavigationStack {
        BreweryList(userFavorites: .preview, displayMode: .all)
    }
    .environment(appModel)
}
