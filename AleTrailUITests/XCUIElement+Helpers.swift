//
//  XCUIElement+Helpers.swift
//  AleTrailUITests
//
//  Created by Jillian Scott on 7/30/25.
//

import XCTest

extension XCUIElement {
    func scrollIfNeededAndWaitForExistence(of subview: XCUIElement, scrollRetryCount: Int = 6) -> Bool {
        var count = 0
        if subview.waitForExistence(timeout: 1) {
            return true
        }
        
        while count < scrollRetryCount {
            swipeUp()
            if subview.waitForExistence(timeout: 1) {
                return true
            }
            count += 1
        }
        
        return false
    }
}
