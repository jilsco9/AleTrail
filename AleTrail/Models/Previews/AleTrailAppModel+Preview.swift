//
//  AleTrailAppModel+Preview.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import Foundation

/// Extension that hold sample data for previews
extension AleTrailAppModel {
    static var preview: AleTrailAppModel = {
       AleTrailAppModel(
        breweryService: MockBreweryService(breweryList: Brewery.previewList)
       )
    }()
}
