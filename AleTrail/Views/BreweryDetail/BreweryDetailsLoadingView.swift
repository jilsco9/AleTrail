//
//  BreweryDetailsLoadingView.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/31/25.
//

import SwiftUI

struct BreweryDetailsLoadingView: View {
    @Environment(AleTrailAppModel.self) private var appModel
    let id: String
    let settings: Settings
        
    @State var error: BreweryServiceError?
    @State var isPresentingBreweryServiceError: Bool = false
    
    @State var viewState: ViewState = .loading
    
    enum ViewState {
        case loading
        case loaded(Brewery)
        case error
    }
    
    func getBreweryDetail() async {
        viewState = .loading
        
        do {
            let brewery = try await appModel.getBreweryByID(id)
            viewState = .loaded(brewery)
        } catch {
            self.error = error
            isPresentingBreweryServiceError = true
            viewState = .error
        }
    }
    
    var body: some View {
        Group {
            switch viewState {
            case .loading:
                ProgressView("Loading details...")
                    .task {
                        await getBreweryDetail()
                    }
            case .loaded(let brewery):
                BreweryDetail(brewery: brewery, settings: settings)
            case .error:
                /// Temporary view to show when in an error state.
                /// Will be replaced with more detailed error handling, such as a retry
                /// and/or navigation back to favorites list on dismissing alert.
                ContentUnavailableView(
                    "Details not found",
                    systemImage: "exclamationmark.triangle",
                    description: Text("Return to favorites list and try again.")
                )
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .alert(
            isPresented: $isPresentingBreweryServiceError,
            error: error,
            actions: { _ in
                Button("OK") {
                    /// Default dismiss functionality
                }
            }, message: { error in
                Text(error.recoverySuggestion ?? "Please try again.")
            }
        )
    }
}

#Preview {
    BreweryDetailsLoadingView(id: Brewery.previewUnion.id, settings: .preview)
}
