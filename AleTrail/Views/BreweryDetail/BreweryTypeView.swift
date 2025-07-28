//
//  BreweryTypeView.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/28/25.
//

import SwiftUI

struct BreweryTypeView: View {
    let breweryTypeTitle: String?
    
    var body: some View {
        if let breweryType = BreweryType(rawValue: breweryTypeTitle ?? "") {
            HStack {
                Image(systemName: breweryType.systemImage)
                    .font(.title)
                    .foregroundStyle(.accent)
                Divider()
                Text(breweryType.title)
                    .font(.headline)
            }
        }
    }
}

#Preview {
    BreweryTypeView(breweryTypeTitle: BreweryType.micro.rawValue)
}
