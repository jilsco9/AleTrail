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
                value: phone
            )
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier(AccessibilityAttributes.BreweryDetail.contactInformationPhone.id)
        }
        
        if let website = brewery.websiteUrl {
            BreweryDetailItemView(
                title: "Website",
                value: website
            )
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier(AccessibilityAttributes.BreweryDetail.contactInformationWebsite.id)
        }
    }
}

#Preview {
    BreweryContactView(brewery: .previewUnion)
}
