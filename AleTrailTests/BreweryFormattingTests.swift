//
//  BreweryFormattingTests.swift
//  AleTrailTests
//
//  Created by Jillian Scott on 7/31/25.
//

import Testing
@testable import AleTrail

struct BreweryFormattingTests {
    @Test("Brewery Single Line Address Formatting - Street Address")
    func singleLineStreet() {
        let brewery = Brewery(
            id: "1",
            name: "Brewery1",
            breweryType: nil,
            address1: "123 Main St",
            address2: "Suite 100",
            address3: nil,
            city: "Cityville",
            stateProvince: "CA",
            postalCode: "12345",
            country: "USA",
            longitude: nil,
            latitude: nil,
            phone: nil,
            websiteUrl: nil,
            state: nil,
            street: "456 Brewery Lane"
        )

        #expect(brewery.formattedSingleLineStreetAddress == "456 Brewery Lane")
    }

    @Test("Brewery Single Line Address Formatting - Multiple Lines")
    func multiLineAddress() {
        let brewery = Brewery(
            id: "2",
            name: "Brewery2",
            breweryType: nil,
            address1: "789 Oak Rd",
            address2: "Bldg A",
            address3: "Floor 2",
            city: nil,
            stateProvince: nil,
            postalCode: nil,
            country: nil,
            longitude: nil,
            latitude: nil,
            phone: nil,
            websiteUrl: nil,
            state: nil,
            street: nil
        )

        #expect(brewery.formattedSingleLineStreetAddress == "789 Oak Rd, Bldg A, Floor 2")
    }

    @Test("Brewery Single Line Address Formatting - Single Line")
    func singleLineAddress() {
        let brewery = Brewery(
            id: "3",
            name: "Brewery3",
            breweryType: nil,
            address1: nil,
            address2: "Unit B",
            address3: nil,
            city: nil,
            stateProvince: nil,
            postalCode: nil,
            country: nil,
            longitude: nil,
            latitude: nil,
            phone: nil,
            websiteUrl: nil,
            state: nil,
            street: nil
        )

        #expect(brewery.formattedSingleLineStreetAddress == "Unit B")
    }

    @Test("Brewery Single Line Address Formatting - Nil")
    func nilStreetAndAddressLines() {
        let brewery = Brewery(
            id: "4",
            name: "Brewery4",
            breweryType: nil,
            address1: nil,
            address2: nil, 
            address3: nil,
            city: nil,
            stateProvince: nil,
            postalCode: nil,
            country: nil,
            longitude: nil,
            latitude: nil,
            phone: nil,
            websiteUrl: nil,
            state: nil,
            street: nil
        )

        #expect(brewery.formattedSingleLineStreetAddress == nil)
    }
}
