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
    let values: [DetailComponent]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title.uppercased())
                .font(.caption)
                .foregroundStyle(.secondary)
            ForEach(values) { value in
                Text(value.text)
                    .font(.body)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    BreweryDetailItemView(
        title: "Address",
        values: [
            .init(text: "123 Main St"),
            .init(text: "Anytown, USA 12345"),
        ]
    )
}
