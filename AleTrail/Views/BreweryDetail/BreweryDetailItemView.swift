//
//  BreweryDetailItemView.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/28/25.
//

import SwiftUI

struct BreweryDetailItemView: View {
    struct DetailComponent: Identifiable {
        let id = UUID()
        let text: String
    }
    
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title.uppercased())
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.body)
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    BreweryDetailItemView(
        title: "Address",
        value: "123 Main St"
    )
}
