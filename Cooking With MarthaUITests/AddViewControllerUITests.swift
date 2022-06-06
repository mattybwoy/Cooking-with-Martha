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
        app/*@START_MENU_TOKEN@*/.staticTexts["Add"]/*[[".buttons[\"Add\"].staticTexts[\"Add\"]",".staticTexts[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_WhenEmptyTitleField_ThrowAlert() throws {
        app.buttons["Add"].tap()
            
        XCTAssertTrue(app.alerts["Empty title field"].waitForExistence(timeout: 1))
    }
    
    func test_WhenEmptyTypeField_ThrowAlert() throws {
        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText("Pizza")
        let typeField = app.textFields["Type"]
        typeField.tap()
        app.buttons["Add"].tap()
            
        XCTAssertTrue(app.alerts["Empty type field"].waitForExistence(timeout: 1))
    }
    
    func test_WhenCategoryUnselected_ThrowAlert() throws {
        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText("Pizza")
        let typeField = app.textFields["Type"]
        typeField.tap()
        typeField.typeText("Italian")
        app.textViews.staticTexts["Description"].tap()
        app.buttons["Add"].tap()
        
        XCTAssertTrue(app.alerts["Empty category field"].waitForExistence(timeout: 1))
    }

    func test_WhenEmptyDescriptionField_ThrowAlert() throws {
        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText("Pizza")
        let typeField = app.textFields["Type"]
        typeField.tap()
        typeField.typeText("Italian")
        app.buttons["Category"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Side"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Side\"]",".staticTexts[\"Side\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.textViews.staticTexts["Description"].tap()
        app.buttons["Add"].tap()
        
        XCTAssertTrue(app.alerts["Empty description field"].waitForExistence(timeout: 1))
    }
    
    func test_WhenAllFieldsCompleted_ProvideConfirmationMessage() throws {
        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText("Pizza")
        let typeField = app.textFields["Type"]
        typeField.tap()
        typeField.typeText("Italian")
        let descriptionField = app.textViews.containing(.staticText, identifier:"Description").element
        descriptionField.tap()
        descriptionField.typeText("Cook in Oven")
        titleField.tap()
        app.buttons["Add"].tap()
        
        XCTAssertTrue(app.alerts["recipe added confirmation"].waitForExistence(timeout: 1))
    }
}
