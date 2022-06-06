//
//  DeleteViewController.swift
//  Cooking With MarthaUITests
//
//  Created by Matthew Lock on 06/06/2022.
//

import XCTest

class DeleteViewController: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        app.staticTexts["Delete"].tap()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_WhenEmptyTextField_ThrowAlert() throws {
        app.buttons["Delete"].tap()
            
        XCTAssertTrue(app.alerts["Empty field"].waitForExistence(timeout: 1))
    }
    
    func test_WhenNoMatchingRecipeFound_ThrowAlert() throws {
        let textField = app.textFields["Recipe name"]
        textField.tap()
        textField.typeText("Pizzorr")
        app.buttons["Delete"].tap()
            
        XCTAssertTrue(app.alerts["No match found"].waitForExistence(timeout: 1))
    }
    
    func test_WhenMatchingRecipeFound_ThrowConfirmationMessage() throws {
        let textField = app.textFields["Recipe name"]
        textField.tap()
        textField.typeText("Corba")
        app.buttons["Delete"].tap()
            
        XCTAssertTrue(app.alerts["Deleted confirmation"].waitForExistence(timeout: 1))
    }

}
