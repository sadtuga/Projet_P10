//
//  BonsPetitsPlatsTests.swift
//  BonsPetitsPlatsTests
//
//  Created by Marques Lucas on 11/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import XCTest
@testable import BonsPetitsPlats

class BonsPetitsPlatsTests: XCTestCase {
    
    let yummly = YummlyService()

    func testSearchRecipesShouldReturnARecipeArray() {
        let expectation = XCTestExpectation(description: "Wait for request.")
        
        yummly.getReciteList(text: "soup") { (succes, recipe) in
            XCTAssertTrue(succes)
            XCTAssertNotNil(recipe)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testGetRecipeDetailsShouldUpdateRecipeWithRecipeURL() {
        let expectation = XCTestExpectation(description: "Wait for request.")
        
        yummly.detailsRecipe(id: "Busy-Day-Soup-2553114") { (succes, recipe) in
            XCTAssertTrue(succes)
            XCTAssertNotNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testGetImageShouldReturnAnImage() {
        let imageUrl = URL(string: "https://lh3.googleusercontent.com/GIRatm4HOl4_RCQoCEtA4ZKeP8J9G6gi4a7_wYmQUHEmkkKstAno67BzodTEYtW3y6sxpI8JIV0NYoo7RnedRw=s200")!
        
        let expectation = XCTestExpectation(description: "Wait for request.")
        
        yummly.getImage(url: imageUrl) { (succes, image) in
            XCTAssertNotNil(image)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }

}
