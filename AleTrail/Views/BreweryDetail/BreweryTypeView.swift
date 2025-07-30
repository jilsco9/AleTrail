//
//  BreweryTypeView.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/28/25.
//

import SwiftUI

struct BreweryTypeView: View {
    let breweryType: BreweryType
    
    var body: some View {
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

#Preview {
    BreweryTypeView(breweryType: BreweryType.micro)
}
