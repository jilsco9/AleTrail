//
//  View+AccessibilityModifier.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/28/25.
//

import SwiftUI

struct AccessibilityModifier: ViewModifier {
    let accessibility: Accessibility
    func body(content: Content) -> some View {
        content
            .accessibilityIdentifier(accessibility.id)
            .accessibilityLabel(accessibility.accessibilityLabel ?? "")
            .accessibilityHint(accessibility.accessibilityHint ?? "")
    }
}

extension View {
    func accessibility(_ accessibility: Accessibility) -> some View {
        modifier(AccessibilityModifier(accessibility: accessibility))
    }
}
