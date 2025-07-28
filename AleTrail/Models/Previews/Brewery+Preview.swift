//
//  Brewery+Preview.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import Foundation

/// Extension that hold sample data for previews and mock services
extension Brewery {
    static var previewList: [Brewery] = {
        [
            previewUnion,
            previewFlix,
            previewDannyBoy,
            previewMisconduct,
            previewEastCliff,
            previewHumbleSea
        ]
    }()
    
    static var previewFavoritesList: [Brewery] {
        [
            previewUnion,
            previewMisconduct
        ]
    }
    
    static var previewUnion: Brewery = {
        Brewery(
            id: "6f07acc5-3db8-4380-b30f-98d256184c56",
            name: "Union Brewing",
            breweryType: "micro",
            address1: "622 S Rangeline Rd Ste Q",
            address2: nil,
            address3: nil,
            city: "Carmel",
            stateProvince: "Indiana",
            postalCode: "46032-2152",
            country: "United States",
            longitude: -86.129922,
            latitude: 39.966276,
            phone: "3175644466",
            websiteUrl: "http://www.unionbrewingco.com",
            state: "Indiana",
            street: "622 S Rangeline Rd Ste Q"
        )
    }()
    
    static var previewDannyBoy: Brewery = {
        Brewery(
            id: "67935791-24ca-4793-ad6f-5755a7189645",
            name: "Danny Boy Beer Works",
            breweryType: "brewpub",
            address1: "12702 Meeting House Rd",
            address2: nil,
            address3: nil,
            city: "Carmel",
            stateProvince: "Indiana",
            postalCode: "46032-7292",
            country: "United States",
            longitude: -86.1971767,
            latitude: 39.971556,
            phone: "3176698080",
            websiteUrl: "http://www.dannyboybeerworks.com",
            state: "Indiana",
            street: "12702 Meeting House Rd"
        )
    }()
    
    static var previewFlix: Brewery = {
        Brewery(
            id: "d339cf65-cab2-4797-9e89-0c2e8bf3e3fb",
            name: "Flix Brewhouse",
            breweryType: "brewpub",
            address1: "2206 E 116th St",
            address2: nil,
            address3: nil,
            city: "Carmel",
            stateProvince: "Indiana",
            postalCode: "46032-3215",
            country: "United States",
            longitude: -86.0897644,
            latitude: 39.9567195,
            phone: "5122442739",
            websiteUrl: nil,
            state: "Indiana",
            street: "2206 E 116th St"
        )
    }()
    
    static var previewMisconduct: Brewery = {
        Brewery(
            id: "4552be6f-35d3-4cd5-b4ba-fde9785eb275",
            name: "Misconduct Brewing",
            breweryType: "planning",
            address1: nil,
            address2: nil,
            address3: nil,
            city: "Carmel",
            stateProvince: "Indiana",
            postalCode: "46033-9414",
            country: "United States",
            longitude: nil,
            latitude: nil,
            phone: nil,
            websiteUrl: nil,
            state: "Indiana",
            street: nil
        )
    }()
    
    static var previewEastCliff: Brewery = {
        Brewery(
            id: "bb27831d-d4ee-41e0-b11b-7faa561b12ca",
            name: "East Cliff Brewing Company",
            breweryType: "micro",
            address1: "21517 E Cliff Dr",
            address2: nil,
            address3: nil,
            city: "Santa Cruz",
            stateProvince: "California",
            postalCode: "95062-4844",
            country: "United States",
            longitude: -122.0136488,
            latitude: 36.9684053,
            phone: "8317135540",
            websiteUrl: "http://www.eastcliffbrewing.com/",
            state: "California",
            street: "21517 E Cliff Dr"
        )
    }()
    
    static var previewHumbleSea: Brewery = {
        Brewery(
            id: "21c8faee-c122-4f6f-9bcb-3f5374bead5a",
            name: "Humble Sea Brewing Co",
            breweryType: "brewpub",
            address1: "820 Swift St",
            address2: nil,
            address3: nil,
            city: "Santa Cruz",
            stateProvince: "California",
            postalCode: "95060-5866",
            country: "United States",
            longitude: -122.0490197,
            latitude: 36.9595996,
            phone: "8314316189",
            websiteUrl: "http://www.humblesea.com",
            state: "California",
            street: "820 Swift St"
        )
    }()
}
