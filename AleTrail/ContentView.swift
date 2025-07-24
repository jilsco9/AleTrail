//
//  ContentView.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/23/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
        
    var body: some View {
        NavigationStack {
            BreweryList()
            // TODO: - Toolbar with menu buttons
            //            .toolbar {
            //                ToolbarItem(placement: .navigationBarTrailing) {
            //                    EditButton()
            //                }
            //                ToolbarItem {
            //                    Button(action: addItem) {
            //                        Label("Add Item", systemImage: "plus")
            //                    }
            //                }
            //            }
                .navigationTitle("All Breweries")
        }
    }
}

struct BreweryList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoriteBreweries]
    
    var userFavorites: FavoriteBreweries? {
        favorites.first
    }
    
    let service = AleTrailBreweryService()
    
    @State var displayedBreweries: [Brewery] = []
    @State var selectedBrewery: Brewery?
        
    // TODO: - Move this to data aggregate model
    func showInitialBreweries() async {
        do {
            if let favoriteBreweries = userFavorites {
                print(favoriteBreweries.ids)
                displayedBreweries = try await service.getBreweries(byIDs: Array(favoriteBreweries.ids))
            } else {
                modelContext.insert(FavoriteBreweries(ids: []))
                displayedBreweries = try await service.getBreweries()
            }
        } catch {
            debugPrint("Error fetching breweries: \(error)")
        }
    }
    
    private func addFavorite(id: String) {
        userFavorites?.ids.insert(id) // TODO: - throw error if first returns nil?
    }
    
    private func removeFavorite(id: String) {
        userFavorites?.ids.remove(id) // TODO: - throw error if first returns nil?
    }
    
    var body: some View {
        List(displayedBreweries) { brewery in
            NavigationLink(brewery.name) {
                Text(brewery.name)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(
                                userFavorites?.ids.contains(brewery.id) == true ? "Remove Favorite" : "Add Favorite",
                                systemImage: userFavorites?.ids.contains(brewery.id) == true ? "heart.fill" : "heart",
                                action: {
                                    userFavorites?.ids.contains(brewery.id) == true ? removeFavorite(id: brewery.id) : addFavorite(id: brewery.id)
                                }
                            )
                        }
                    }
            }
        }
        .task {
            await showInitialBreweries()
        }
    }
}

struct BreweryDetail: View {
    let brewery: Brewery
    
    var body: some View {
        Text(brewery.name)
    }
}

//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }

//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}

#Preview {
    ContentView()
        .modelContainer(for: FavoriteBreweries.self, inMemory: true)
}
