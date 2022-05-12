//
//  Cooking_With_MarthaUITests.swift
//  Cooking With MarthaUITests
//
//  Created by Matthew Lock on 07/05/2022.
//

import XCTest

class Cooking_With_MarthaUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testViewController_DisplaysCardSliderScreen() throws {
        app.buttons["cookbook"].tap()
        let recipeBookHeader = app.staticTexts["Recipe Book"]
        
        XCTAssertEqual(recipeBookHeader.label, "Recipe Book")
        XCTAssertNotNil(recipeBookHeader)
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
