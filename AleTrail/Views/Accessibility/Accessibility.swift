//
//  Accessibility.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/28/25.
//

import Foundation

struct AccessibilityIdentifiers {}

protocol Accessibility {
    var screenID: String { get }
    var componentID: String { get }
    var accessibilityLabel: String? { get }
    var accessibilityHint: String? { get }
}

extension Accessibility {
    var id: String {
        "\(screenID).\(componentID)"
    }
}
