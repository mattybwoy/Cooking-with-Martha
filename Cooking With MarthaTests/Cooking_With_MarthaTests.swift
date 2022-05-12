//
//  Cooking_With_MarthaTests.swift
//  Cooking With MarthaTests
//
//  Created by Matthew Lock on 07/05/2022.
//

import XCTest
@testable import Cooking_With_Martha

class Cooking_With_MarthaTests: XCTestCase {
    
    var sut: DataManager!

    override func setUpWithError() throws {
        sut = DataManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_RecipesLoadedWhenDataManagerIsInstantiated() throws {
        
        sut.getRecipes { Recipes in
            XCTAssertEqual(Recipes.count, 25)
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
