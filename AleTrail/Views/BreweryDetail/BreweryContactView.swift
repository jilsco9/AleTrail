//
//  BreweryContactView.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/28/25.
//

import SwiftUI

struct BreweryContactView: View {
    let brewery: Brewery
    
    var body: some View {
        if let phone = brewery.phone {
            BreweryDetailItemView(
                title: "Phone Number",
                values: [BreweryDetailItemView.DetailComponent(text: phone)]
            )
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier(AccessibilityAttributes.BreweryDetail.contactInformationPhone.id)
        }
        
        if let website = brewery.websiteUrl {
            BreweryDetailItemView(
                title: "Website",
                values: [BreweryDetailItemView.DetailComponent(text: website)]
            )
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier(AccessibilityAttributes.BreweryDetail.contactInformationWebsite.id)
        }
    }
}

#Preview {
    BreweryContactView(brewery: .previewUnion)
}
