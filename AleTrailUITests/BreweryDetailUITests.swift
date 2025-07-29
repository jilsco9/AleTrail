//
//  BreweryDetailUITests.swift
//  AleTrailUITests
//
//  Created by Jillian Scott on 7/28/25.
//

import XCTest

final class BreweryDetailUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func testBreweryListScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Confirm Union Brewing list item and tap
        let unionBreweryNavigationLink = app.buttons["BreweryList.breweryListItem.6f07acc5-3db8-4380-b30f-98d256184c56"].firstMatch
        let unionBreweryExists = unionBreweryNavigationLink.waitForExistence(timeout: 1)
        XCTAssert(unionBreweryExists, "Expected item with id 6f07acc5-3db8-4380-b30f-98d256184c56 to exist in brewery list.")
        unionBreweryNavigationLink.tap()
        
//        // General Information
//        let generalInformationSection = app.otherElements["BreweryDetail.generalInformation"].firstMatch
//        XCTAssert(generalInformationSection.exists, "Expected General Information section to exist.")
//        
//        // Location Information
//        let locationInformationSection = app.tables.cells["BreweryDetail.locationInformation"].firstMatch
//        XCTAssert(locationInformationSection.exists, "Expected Location Information section to exist.")
//        
//        // Contact Information
//        let contactInformationSection = app.tables.cells["BreweryDetail.contactInformation"].firstMatch
//        XCTAssert(contactInformationSection.exists, "Expected Contact Information section to exist.")
        
    }
    
    @MainActor
    func testAddBreweryToFavorites() throws {
        let app = XCUIApplication()
        app.activate()
        
        // Wait for app data to load, then
        // navigate to Favorites list and confirm empty
        let favoritesButton = app.buttons["BreweryList.favoritesButton"].firstMatch
        let favoritesButtonExists = favoritesButton.waitForExistence(timeout: 1)
        XCTAssert(favoritesButtonExists, "Expected favorites button to exist.")
        favoritesButton.tap()
        
        // Confirm favorites list is empty
        let emptyFavoritesListExists = app.otherElements["BreweryList.noBreweriesView"].waitForExistence(timeout: 1)
        XCTAssert(emptyFavoritesListExists, "Expected favorites list to be empty.")
        
        // Navigate back to All breweries list and tap Union Brewing
        app.buttons["BreweryList.allBreweriesButton"].tap()
        let unionBrewingNavigationLink = app.buttons["BreweryList.breweryListItem.6f07acc5-3db8-4380-b30f-98d256184c56"]
        unionBrewingNavigationLink.tap()
        
        // Expect favorite button to not be selected
        XCTAssertEqual(app.buttons["BreweryDetail.favoriteButton"].label, "Brewery is not favorited")
        
        app.buttons["BreweryDetail.favoriteButton"].firstMatch.tap()
        
        XCTAssertEqual(app.buttons["BreweryDetail.favoriteButton"].label, "Brewery is favorited")
        
        app.buttons["BackButton"].firstMatch.tap()
        
        app.buttons["BreweryList.favoritesButton"].firstMatch.tap()
        
        // Confirm Union Brewing list item and tap
        let favoritesUnionBreweryNavigationLink = app.buttons["BreweryList.breweryListItem.6f07acc5-3db8-4380-b30f-98d256184c56"].firstMatch
        let favoritesUnionBreweryExists = favoritesUnionBreweryNavigationLink.waitForExistence(timeout: 1)
        XCTAssert(favoritesUnionBreweryExists, "Expected item with id 6f07acc5-3db8-4380-b30f-98d256184c56 to exist in brewery list.")
        unionBrewingNavigationLink.tap()
        
        XCTAssertEqual(app.buttons["BreweryDetail.favoriteButton"].label, "Brewery is favorited")
    }
}
