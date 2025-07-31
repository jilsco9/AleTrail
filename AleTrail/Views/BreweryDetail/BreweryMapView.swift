//
//  BreweryMapView.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/31/25.
//

import SwiftUI
import MapKit

struct BreweryMapView: View {
    let latitude: Double
    let longitude: Double
    
    let address: MKAddress?
    
    @State var mapCameraPosition: MapCameraPosition = .automatic
    
    var mapItem: MKMapItem
    
    var locationCoordinate: CLLocationCoordinate2D
    var coordinateDelta: Double = 0.5
    
    var coordinateRegion: MKCoordinateRegion {
        MKCoordinateRegion(
            center: locationCoordinate,
            span: MKCoordinateSpan(
                latitudeDelta: coordinateDelta,
                longitudeDelta: coordinateDelta
            )
        )
    }
    
    init(
        latitude: Double,
        longitude: Double,
        formattedAddressFull: String?,
        singleLineStreetAddress: String?
    ) {
        self.latitude = latitude
        self.longitude = longitude
        
        self.locationCoordinate = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
        
        let location = CLLocation(
            latitude: locationCoordinate.latitude,
            longitude: locationCoordinate.longitude
        )
                
        if let formattedAddressFull {
            address = MKAddress(
                fullAddress: formattedAddressFull,
                shortAddress: singleLineStreetAddress
            )
        } else {
            address = nil
        }
        
        self.mapItem = MKMapItem(location: location, address: address)
        mapItem.name = singleLineStreetAddress
    }
    
    var body: some View {
        Map(position: $mapCameraPosition, interactionModes: []) {
            Marker(item: mapItem)
        }
        .onAppear {
            mapCameraPosition = .region(coordinateRegion)
        }
    }
}

#Preview {
    BreweryMapView(
        latitude: Brewery.previewUnion.latitude!,
        longitude: Brewery.previewUnion.longitude!,
        formattedAddressFull: "123 Main St, Bldg C, Anytown, USA 12345",
        singleLineStreetAddress: "123 Main St, Bldg C"
    )
}
