//
//  Brewery+FormattedAddress.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/31/25.
//

import Foundation
import Contacts

extension Brewery {
    
    /// A single line street address for the Brewery
    ///
    /// Address formats vary by country and region, but MapKit expects
    /// a single line for street address, so we will go with the street address,
    /// if provided, and if not, format our three possible
    /// address lines into one single address line.
    ///
    /// If those are not provided, either, return nil.
    ///
    /// The API is a little unclear on what is expected for each of these
    /// lines, so going with what appears to be the intent, after examining
    /// data returned from the API.
    var formattedSingleLineStreetAddress: String? {
        if let street {
            return street
        }
        
        let streetAddressLines = [address1, address2, address3].compactMap { $0 }
        
        if streetAddressLines.isEmpty {
            return nil
        }
        
        return streetAddressLines.joined(separator: ", ")
    }
    
    var postalAddress: CNPostalAddress {
        let address = CNMutablePostalAddress()
        
        if let street = formattedSingleLineStreetAddress {
            address.street = street
        }
        
        if let postalCode {
            address.postalCode = postalCode
        }
        
        if let city {
            address.city = city
        }
        
        if let country {
            address.country = country
        }
        
        /// Some ambiguity here on whether we should assign
        /// stateProvince to the address state at all. It might be more fitting
        /// to assign to subAdministrativeArea? Again, hard to tell from the data
        /// so we make our best guess that it is appropriate to go by state if it
        /// exists or else fall back to stateProvince if that exists instead.
        if let state = state ?? stateProvince {
            address.state = state
        }
        
        return address
    }
    
    var formattedAddress: String {
        let formatter = CNPostalAddressFormatter()
        return formatter.string(from: postalAddress)
    }
}
