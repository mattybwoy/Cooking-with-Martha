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
    
    func test_WhenAddNewCategorySelected_ThrowAlertIfNoUserInput() throws {
        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText("Pizza")
        let typeField = app.textFields["Type"]
        typeField.tap()
        typeField.typeText("Italian")
        app.buttons["Category"].tap()
        app.tables.staticTexts["Add New"].tap()
        app.alerts["New Category"].scrollViews.otherElements.buttons["Save"].tap()
        
        XCTAssertTrue(app.alerts["Empty category field"].waitForExistence(timeout: 1))
    }
    
    func test_WhenAddNewCategorySelected_AllowUserInput() throws {
        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText("Pizza")
        let typeField = app.textFields["Type"]
        typeField.tap()
        typeField.typeText("Italian")
        let category = app.buttons["Category"]
        category.tap()
        app.tables.staticTexts["Add New"].tap()
        let elementQuery = app.alerts["New Category"].scrollViews.otherElements
        let newCategory = elementQuery.collectionViews.textFields["Enter new category"]
        newCategory.typeText("Vegan")
        elementQuery.buttons["Save"].tap()
                
        XCTAssertNotNil(app.buttons["Vegan"])
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
    
    func test_WhenExistingTitleTyped_ThrowAlert() throws {
        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText("Corba")
        let typeField = app.textFields["Type"]
        typeField.tap()
        typeField.typeText("Italian")
        app.buttons["Category"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Side"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Side\"]",".staticTexts[\"Side\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let descriptionField = app.textViews.containing(.staticText, identifier:"Description").element
        descriptionField.tap()
        descriptionField.typeText("Cook in Oven")
        titleField.tap()
        app.buttons["  Upload Image"].tap()
        app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.images["Photo, March 30, 2018, 8:14 PM"]/*[[".otherElements[\"Photos\"].scrollViews.otherElements",".otherElements[\"Photo, March 30, 2018, 8:14 PM, Photo, August 08, 2012, 10:55 PM, Photo, August 08, 2012, 10:29 PM, Photo, August 08, 2012, 7:52 PM, Photo, October 09, 2009, 10:09 PM, Photo, March 13, 2011, 12:17 AM\"].images[\"Photo, March 30, 2018, 8:14 PM\"]",".images[\"Photo, March 30, 2018, 8:14 PM\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Choose"].tap()
        app.buttons["Add"].tap()
            
        XCTAssertTrue(app.alerts["Existing title alert"].waitForExistence(timeout: 1))
    }
    
    func test_WhenNoImageUploaded_ThrowAlert() throws {
        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText("Pizza")
        let typeField = app.textFields["Type"]
        typeField.tap()
        typeField.typeText("Italian")
        app.buttons["Category"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Side"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Side\"]",".staticTexts[\"Side\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let descriptionField = app.textViews.containing(.staticText, identifier:"Description").element
        descriptionField.tap()
        descriptionField.typeText("Cook in Oven")
        titleField.tap()
        app.buttons["Add"].tap()
            
        XCTAssertTrue(app.alerts["Missing Photo alert"].waitForExistence(timeout: 1))
    }
    
    func test_WhenNoImageUploaded_AfterClickingYesCanDisplayConfirmationMessage() throws {
        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText("Pizza")
        let typeField = app.textFields["Type"]
        typeField.tap()
        typeField.typeText("Italian")
        app.buttons["Category"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Side"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Side\"]",".staticTexts[\"Side\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let descriptionField = app.textViews.containing(.staticText, identifier:"Description").element
        descriptionField.tap()
        descriptionField.typeText("Cook in Oven")
        titleField.tap()
        app.buttons["Add"].tap()
        app/*@START_MENU_TOKEN@*/.alerts["Missing Photo alert"]/*[[".alerts[\"Warning\"]",".alerts[\"Missing Photo alert\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.scrollViews.otherElements.buttons["Yes"].tap()
        
        XCTAssertTrue(app.alerts["recipe added confirmation"].waitForExistence(timeout: 3))
    }
    
    func test_WhenAllFieldsCompleted_ProvideConfirmationMessage() throws {
        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText("Pizza")
        let typeField = app.textFields["Type"]
        typeField.tap()
        typeField.typeText("Italian")
        app.buttons["Category"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Side"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Side\"]",".staticTexts[\"Side\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let descriptionField = app.textViews.containing(.staticText, identifier:"Description").element
        descriptionField.tap()
        descriptionField.typeText("Cook in Oven")
        titleField.tap()
        app.buttons["  Upload Image"].tap()
        app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.images["Photo, March 30, 2018, 8:14 PM"]/*[[".otherElements[\"Photos\"].scrollViews.otherElements",".otherElements[\"Photo, March 30, 2018, 8:14 PM, Photo, August 08, 2012, 10:55 PM, Photo, August 08, 2012, 10:29 PM, Photo, August 08, 2012, 7:52 PM, Photo, October 09, 2009, 10:09 PM, Photo, March 13, 2011, 12:17 AM\"].images[\"Photo, March 30, 2018, 8:14 PM\"]",".images[\"Photo, March 30, 2018, 8:14 PM\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Choose"].tap()
        app.buttons["Add"].tap()
        
        XCTAssertTrue(app.alerts["recipe added confirmation"].waitForExistence(timeout: 3))
    }
    
    
}
