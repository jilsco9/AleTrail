//
//  BreweryLocationView.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/28/25.
//

import SwiftUI

struct BreweryLocationView: View {
    let brewery: Brewery
    
    var addressLines: [BreweryDetailItemView.DetailComponent] {
        [
            brewery.address1 ?? brewery.street,
            brewery.address2,
            brewery.address3
        ]
            .compactMap { $0 }
            .map { BreweryDetailItemView.DetailComponent(text: $0) }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if !addressLines.isEmpty {
                BreweryDetailItemView(
                    title: "Street Address",
                    values: addressLines
                )
            }
            
            if let city = brewery.city {
                BreweryDetailItemView(
                    title: "City",
                    values: [BreweryDetailItemView.DetailComponent(text: city)]
                )
            }
            
            if let stateProvince = brewery.stateProvince ?? brewery.state {
                BreweryDetailItemView(
                    title: "State/Province",
                    values: [BreweryDetailItemView.DetailComponent(text: stateProvince)]
                )
            }
            
            if let postalCode = brewery.postalCode {
                BreweryDetailItemView(
                    title: "Postal Code",
                    values: [BreweryDetailItemView.DetailComponent(text: postalCode)]
                )
            }
            
            if let country = brewery.country {
                BreweryDetailItemView(
                    title: "Country",
                    values: [BreweryDetailItemView.DetailComponent(text: country)]
                )
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(AccessibilityAttributes.BreweryDetail.locationInformation.id)
        
        if brewery.latitude != nil || brewery.longitude != nil {
            VStack(alignment: .leading, spacing: 10) {
                if let latitude = brewery.latitude {
                    BreweryDetailItemView(
                        title: "Latitude",
                        values: [BreweryDetailItemView.DetailComponent(text: String(latitude))]
                    )
                }
                
                if let longitude = brewery.longitude {
                    BreweryDetailItemView(
                        title: "Longitude",
                        values: [BreweryDetailItemView.DetailComponent(text: String(longitude))]
                    )
                }
            }
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier(AccessibilityAttributes.BreweryDetail.locationCoordinates.id)
        }
    }
}

#Preview {
    BreweryLocationView(brewery: .previewUnion)
}
