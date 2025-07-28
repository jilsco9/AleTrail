//
//  Brewery.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/24/25.
//

import Foundation

/// Brewery model - Primary data response model for the app
///
/// Contains name, brewery type, contact information, and location information
struct Brewery: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let breweryType: String?
    let address1: String?
    let address2: String?
    let address3: String?
    let city: String?
    let stateProvince: String?
    let postalCode: String?
    let country: String?
    let longitude: Double?
    let latitude: Double?
    let phone: String?
    let websiteUrl: String?
    let state: String?
    let street: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case breweryType = "brewery_type"
        case address1 = "address_1"
        case address2 = "address_2"
        case address3 = "address_3"
        case city
        case stateProvince = "state_province"
        case postalCode = "postal_code"
        case country
        case longitude
        case latitude
        case phone
        case websiteUrl = "website_url"
        case state
        case street
    }
}
