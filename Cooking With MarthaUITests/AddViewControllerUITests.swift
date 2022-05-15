//
//  AddViewControllerUITests.swift
//  Cooking With MarthaUITests
//
//  Created by Matthew Lock on 15/05/2022.
//

import XCTest

class AddViewControllerUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()

        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

        func test_WhenEmptyRecipeFields_ThrowAlert() throws {
            app/*@START_MENU_TOKEN@*/.staticTexts["Add"]/*[[".buttons[\"Add\"].staticTexts[\"Add\"]",".staticTexts[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.buttons["Add"].tap()
            
        XCTAssertTrue(app.alerts["Empty title field"].waitForExistence(timeout: 1))
    }

}
