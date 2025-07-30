//
//  BreweryListUITests.swift
//  AleTrailUITests
//
//  Created by Jillian Scott on 7/27/25.
//

import XCTest

final class BreweryListUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testBreweryListScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        /// Wait for existence of list view (wait for app to finish initializing)
        let breweryList = app.collectionViews["BreweryList.list"]
        XCTAssert(
            breweryList.waitForExistence(timeout: 1),
            "Did not find brewery list."
        )
        
        /// Wait for data to load (wait for existence of first expected list item)
        let unionBreweryNavigationLink = app.buttons["BreweryList.breweryListItem.6f07acc5-3db8-4380-b30f-98d256184c56"]
        let unionBreweryExists = unionBreweryNavigationLink.waitForExistence(timeout: 1)
        XCTAssert(
            unionBreweryExists,
            "Did not find item with id 6f07acc5-3db8-4380-b30f-98d256184c56 in brewery list."
        )
        
        // Confirm navigation elements
        let favoritesButton = app.buttons["BreweryList.favoritesButton"]
        XCTAssert(
            favoritesButton.exists,
            "Did not find Favorite Breweries navigation button."
        )
        
        let allBreweriesButton = app.buttons["BreweryList.allBreweriesButton"]
        XCTAssert(
            allBreweriesButton.exists,
            "Did not find All Breweries navigation button"
        )
        
        let navigationTitle = app.navigationBars.staticTexts["Breweries"]
        XCTAssertEqual(navigationTitle.label, "Breweries")
        
        // Validate brewery row
        XCTAssert(
            unionBreweryNavigationLink.staticTexts["Union Brewing"].exists
        )

        // Ensure brewery row navigates away from list
        unionBreweryNavigationLink.tap()
        
        /// Wait for existence of list view (wait for app to finish navigation using waitForExistence)
        let detailList = app.collectionViews["BreweryDetail.list"]
        XCTAssert(
            detailList.waitForExistence(timeout: 1),
            "Did not find brewery detail list."
        )
        
        XCTAssertFalse(breweryList.exists)
    }
    
//    @MainActor
//    func testAccessibility() throws {
//        continueAfterFailure = true
//        
//        let app = XCUIApplication()
//        app.launch()
//        
//        /// Wait for existence of list view (wait for app to finish initializing)
//        let breweryList = app.collectionViews["BreweryList.list"]
//        XCTAssert(
//            breweryList.waitForExistence(timeout: 1),
//            "Did not find brewery list."
//        )
//        
//        /// Wait for data to load (wait for existence of first expected list item)
//        let unionBreweryNavigationLink = app.buttons["BreweryList.breweryListItem.6f07acc5-3db8-4380-b30f-98d256184c56"]
//        let unionBreweryExists = unionBreweryNavigationLink.waitForExistence(timeout: 1)
//        XCTAssert(
//            unionBreweryExists,
//            "Did not find item with id 6f07acc5-3db8-4380-b30f-98d256184c56 in brewery list."
//        )
//        
//        try app.performAccessibilityAudit()
//    }
}
