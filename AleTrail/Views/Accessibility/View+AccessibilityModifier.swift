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
            .conditionalAccessibilityLabel(accessibility.accessibilityLabel)
            .conditionalAccessibilityHint(accessibility.accessibilityHint)
    }
}

struct ConditionalAccessibilityLabelModifier: ViewModifier {
    let accessibilityLabel: String?
    func body(content: Content) -> some View {
        if let accessibilityLabel {
            content
                .accessibilityLabel(accessibilityLabel)
        } else {
            content
        }
    }
}

struct ConditionalAccessibilityHintModifier: ViewModifier {
    let accessibilityHint: String?
    func body(content: Content) -> some View {
        if let accessibilityHint {
            content
                .accessibilityHint(accessibilityHint)
        } else {
            content
        }
    }
}

extension View {
    func accessibility(_ accessibility: Accessibility) -> some View {
        modifier(AccessibilityModifier(accessibility: accessibility))
    }
}

fileprivate extension View {
    func conditionalAccessibilityLabel(_ accessibilityLabel: String?) -> some View {
        modifier(ConditionalAccessibilityLabelModifier(accessibilityLabel: accessibilityLabel))
    }
    
    func conditionalAccessibilityHint(_ accessibilityHint: String?) -> some View {
        modifier(ConditionalAccessibilityHintModifier(accessibilityHint: accessibilityHint))
    }
}
