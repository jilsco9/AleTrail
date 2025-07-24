//
//  Item.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/23/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
