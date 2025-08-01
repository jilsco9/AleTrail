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
///
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
    
    init(
        id: String,
        name: String,
        breweryType: String?,
        address1: String?,
        address2: String?,
        address3: String?,
        city: String?,
        stateProvince: String?,
        postalCode: String?,
        country: String?,
        longitude: Double?,
        latitude: Double?,
        phone: String?,
        websiteUrl: String?,
        state: String?,
        street: String?
    ) {
        self.id = id
        self.name = name
        self.breweryType = breweryType
        self.address1 = address1
        self.address2 = address2
        self.address3 = address3
        self.city = city
        self.stateProvince = stateProvince
        self.postalCode = postalCode
        self.country = country
        self.longitude = longitude
        self.latitude = latitude
        self.phone = phone
        self.websiteUrl = websiteUrl
        self.state = state
        self.street = street
    }
    
    /// Must implement nonisolated custom decoder init to avoid concurrency warning
    /// in the AleTrailBreweryService.
    nonisolated
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        breweryType = try container.decodeIfPresent(String.self, forKey: .breweryType)
        address1 = try container.decodeIfPresent(String.self, forKey: .address1)
        address2 = try container.decodeIfPresent(String.self, forKey: .address2)
        address3 = try container.decodeIfPresent(String.self, forKey: .address3)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        stateProvince = try container.decodeIfPresent(String.self, forKey: .stateProvince)
        postalCode = try container.decodeIfPresent(String.self, forKey: .postalCode)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        websiteUrl = try container.decodeIfPresent(String.self, forKey: .websiteUrl)
        state = try container.decodeIfPresent(String.self, forKey: .state)
        street = try container.decodeIfPresent(String.self, forKey: .street)
    }
    
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
