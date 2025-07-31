//
//  BreweryLocationView.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/28/25.
//

import SwiftUI

struct BreweryLocationView: View {
    let brewery: Brewery
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let streetAddress = brewery.formattedSingleLineStreetAddress {
                BreweryDetailItemView(
                    title: "Street Address",
                    value: streetAddress
                )
            }
            
            if let city = brewery.city {
                BreweryDetailItemView(
                    title: "City",
                    value: city
                )
            }
            
            if let stateProvince = brewery.stateProvince ?? brewery.state {
                BreweryDetailItemView(
                    title: "State/Province",
                    value: stateProvince
                )
            }
            
            if let postalCode = brewery.postalCode {
                BreweryDetailItemView(
                    title: "Postal Code",
                    value: postalCode
                )
            }
            
            if let country = brewery.country {
                BreweryDetailItemView(
                    title: "Country",
                    value: country
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
                        value: String(latitude)
                    )
                }
                
                if let longitude = brewery.longitude {
                    BreweryDetailItemView(
                        title: "Longitude",
                        value: String(longitude)
                    )
                }
                
                if let latitude = brewery.latitude, let longitude = brewery.longitude {
                    BreweryMapView(
                        latitude: latitude,
                        longitude: longitude,
                        formattedAddressFull: brewery.formattedAddress,
                        singleLineStreetAddress: brewery.formattedSingleLineStreetAddress
                    )
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
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
