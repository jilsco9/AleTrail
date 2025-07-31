//
//  BreweryDetailUITests.swift
//  AleTrailUITests
//
//  Created by Jillian Scott on 7/28/25.
//

import XCTest

final class BreweryDetailUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    @MainActor
    func testBreweryDetailScreen() async throws {
        let app = XCUIApplication()
        app.launch()
        
        // Confirm Union Brewing list item and tap
        let unionBreweryNavigationLink = app.buttons["BreweryList.breweryListItem.6f07acc5-3db8-4380-b30f-98d256184c56"]
        let unionBreweryExists = unionBreweryNavigationLink.waitForExistence(timeout: 3)
        XCTAssert(
            unionBreweryExists,
            "Expected item with id 6f07acc5-3db8-4380-b30f-98d256184c56 to exist in brewery list."
        )
        unionBreweryNavigationLink.tap()
        
        /// Wait for existence of list view (wait for app to finish navigation using waitForExistence)
        let detailList = app.collectionViews["BreweryDetail.list"]
        XCTAssert(
            detailList.waitForExistence(timeout: 1),
            "Did not find brewery detail list."
        )
        
        // MARK: General Information
        /// Check for existence of general information
        let generalInformation = detailList.cells.staticTexts["BreweryDetail.generalInformation"].firstMatch
        let generalInformationRowExists = detailList.scrollIfNeededAndWaitForExistence(
            of: generalInformation
        )
        XCTAssert(
            generalInformationRowExists,
            "Did not find general information row in detail list."
        )
        
        /// Validate brewery general information row
        XCTAssertEqual(
            generalInformation.label,
            "Union Brewing, Carmel, Indiana, United States"
        )
        
        /// Check for existence of brewery type row
        let breweryType = detailList.cells.staticTexts["BreweryDetail.breweryType"]
        let breweryTypeRowExists = detailList.scrollIfNeededAndWaitForExistence(
            of: breweryType
        )
        XCTAssert(
            breweryTypeRowExists,
            "Did not find brewery type row in detail list."
        )
        
        /// Validate brewery type row
        XCTAssertEqual(
            breweryType.label,
            "Brewery type: Micro"
        )
        
        // MARK: Location Information
        
        /// Check existence of location information row
        let locationInformation = detailList.otherElements["BreweryDetail.locationInformation"]
        let locationInformationRowExists = detailList.scrollIfNeededAndWaitForExistence(of: locationInformation)
        XCTAssert(
            locationInformationRowExists,
            "Did not find location information row in detail list."
        )
        
        /// Validate location information row
        // Street address
        XCTAssert(
            locationInformation.staticTexts["622 S Rangeline Rd Ste Q"].exists,
            "Expected Union Brewing address to exist."
        )
        // City
        XCTAssert(
            locationInformation.staticTexts["Carmel"].exists,
            "Expected Union Brewing city to exist."
        )
        // State/Province
        XCTAssert(
            locationInformation.staticTexts["Indiana"].exists,
            "Expected Union Brewing state/province to exist."
        )
        // Postal Code
        XCTAssert(
            locationInformation.staticTexts["46032-2152"].exists,
            "Expected Union Brewing address to exist."
        )
        // Country
        XCTAssert(
            locationInformation.staticTexts["United States"].exists,
            "Expected Union Brewing country to exist."
        )
        
        /// Check existence of coordinates row
        let locationCoordinates = detailList.cells.otherElements["BreweryDetail.locationCoordinates"]
        let locationCoordinatesRowExists = detailList.scrollIfNeededAndWaitForExistence(
            of: locationCoordinates
        )
        XCTAssert(
            locationCoordinatesRowExists,
            "Did not find location coodinates row in detail list."
        )
        
        /// Validate coordinate row
        XCTAssert(
            locationCoordinates.staticTexts["39.966276"].exists,
            "Expected Union Brewing latitude to exist."
        )
        XCTAssert(
            locationCoordinates.staticTexts["-86.129922"].exists,
            "Expected Union Brewing longitude to exist."
        )
        
        // MARK: Contact Section
        
        /// Check existence of phone number row
        let contactInformationPhone = detailList.cells.otherElements["BreweryDetail.contactInformationPhone"]
        let phoneNumberRowExists = detailList.scrollIfNeededAndWaitForExistence(of: contactInformationPhone)
        XCTAssert(
            phoneNumberRowExists,
            "Did not find contact information phone number row in detail list."
        )
        
        /// Validate phone number row
        XCTAssert(
            contactInformationPhone.staticTexts["3175644466"].exists,
            "Expected Union Brewing phone number to exist."
        )
        
        /// Check existence of website row
        let contactInformationWebsite = detailList.cells.otherElements["BreweryDetail.contactInformationWebsite"]
        let websiteRowExists = detailList.scrollIfNeededAndWaitForExistence(of: contactInformationWebsite)
        XCTAssert(
            websiteRowExists,
            "Did not find contact information website row in detail list."
        )
        
        /// Validate website row
        XCTAssert(
            contactInformationWebsite.staticTexts["http://www.unionbrewingco.com"].exists,
            "Expected Union Brewing website to exist."
        )
    }
    
    @MainActor
    func testAddBreweryToFavorites() throws {
        let app = XCUIApplication()
        app.activate()
        
        // Wait for app data to load. Confirm first brewery row exists.
        // Confirm Union Brewing list item and tap
        let favoritesUnionBreweryNavigationLink = app.buttons["BreweryList.breweryListItem.6f07acc5-3db8-4380-b30f-98d256184c56"]
        let favoritesUnionBreweryExists = favoritesUnionBreweryNavigationLink.waitForExistence(timeout: 3)
        XCTAssert(
            favoritesUnionBreweryExists,
            "Expected item with id 6f07acc5-3db8-4380-b30f-98d256184c56 to exist in brewery list."
        )
        
        // Navigate to Favorites list
        app.buttons["BreweryList.favoritesButton"].tap()
        
        // Confirm favorites list is empty
        let emptyFavoritesListExists = app.otherElements["BreweryList.noBreweriesView"].waitForExistence(timeout: 1)
        XCTAssert(
            emptyFavoritesListExists,
            "Expected favorites list to be empty."
        )
        
        // Navigate back to All breweries list and tap Union Brewing
        app.buttons["BreweryList.allBreweriesButton"].tap()
        let unionBrewingNavigationLink = app.buttons["BreweryList.breweryListItem.6f07acc5-3db8-4380-b30f-98d256184c56"]
        unionBrewingNavigationLink.tap()
        
        // Expect favorite button to not be selected
        XCTAssertEqual(
            app.buttons["BreweryDetail.favoriteButton"].label,
            "Brewery is not favorited"
        )
        
        app.buttons["BreweryDetail.favoriteButton"].firstMatch.tap()
        
        XCTAssertEqual(
            app.buttons["BreweryDetail.favoriteButton"].label,
            "Brewery is favorited"
        )
        
        app.buttons["BackButton"].firstMatch.tap()
        
        app.buttons["BreweryList.favoritesButton"].firstMatch.tap()
        
        // Confirm Union Brewing list item and tap
        unionBrewingNavigationLink.tap()
        
        // Confirm favorites button favorited state
        XCTAssertEqual(
            app.buttons["BreweryDetail.favoriteButton"].label,
            "Brewery is favorited"
        )
    }
    
    @MainActor
    func testAccessibility() throws {
        continueAfterFailure = true
        
        let app = XCUIApplication()
        app.launch()
        
        // Confirm Union Brewing list item and tap
        let unionBreweryNavigationLink = app.buttons["BreweryList.breweryListItem.6f07acc5-3db8-4380-b30f-98d256184c56"]
        let unionBreweryExists = unionBreweryNavigationLink.waitForExistence(timeout: 3)
        XCTAssert(
            unionBreweryExists,
            "Expected item with id 6f07acc5-3db8-4380-b30f-98d256184c56 to exist in brewery list."
        )
        unionBreweryNavigationLink.tap()
        
        /// Wait for existence of list view (wait for app to finish navigation using waitForExistence)
        let detailList = app.collectionViews["BreweryDetail.list"]
        XCTAssert(
            detailList.waitForExistence(timeout: 1),
            "Did not find brewery detail list."
        )
        
        /// Explicitly opting to not allow two issues to cause the test to fail:
        /// "Contrast nearly passed" and "Dynamic Type font sizes are partially unsupported".
        /// Some native elements are failing those tests, even when their font size can quite visibly and
        /// fully scale up dynamically. I included a print statement to represent the fact that we could
        /// still alert ourselves as to issues existing without requiring that they fully fail the test.
        try app.performAccessibilityAudit { issue throws -> Bool in
            switch issue.auditType {
            // Handle contrast and dynamic type issues
            case .contrast, .dynamicType:
                let issueDescriptionMessage = """
                ----------
                Encountered a disabled accessibility audit issue when running BreweryDetailUITests.testAccessibility().
                Description: \(issue.compactDescription)
                Details: \(issue.detailedDescription)
                ----------
                """
                print(issueDescriptionMessage)
                
                return true
            default:
                // Do not handle the issue, and allow it to fail the test as normal
                return false
            }
        }
    }
}
