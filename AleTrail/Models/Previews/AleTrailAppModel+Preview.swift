//
//  AleTrailAppModel+Preview.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/26/25.
//

import Foundation

extension AleTrailAppModel {
    static var preview: AleTrailAppModel = {
       AleTrailAppModel(breweryService: MockBreweryService())
    }()
}
