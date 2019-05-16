//
//  BonsPetitsPlatsTests.swift
//  BonsPetitsPlatsTests
//
//  Created by Marques Lucas on 11/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import XCTest
@testable import BonsPetitsPlats

class YummlyServiceTestCase: XCTestCase {

    let yummly = YummlyService()
    let urlImage: String = "https://lh3.googleusercontent.com/GIRatm4HOl4_RCQoCEtA4ZKeP8J9G6gi4a7_wYmQUHEmkkKstAno67BzodTEYtW3y6sxpI8JIV0NYoo7RnedRw=s200"

    // Test if the getReciteList method works
    func testGetRecipesListShouldReturnARecipeArray() {
        let expectation = XCTestExpectation(description: "Wait for request.")

        yummly.getReciteList(text: "soup") { (succes, recipe) in
            XCTAssertTrue(succes)
            XCTAssertNotNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    // Test if the detailsRecipe method works
    func testDetailsRecipeShouldReturnARecipeDetails() {
        let expectation = XCTestExpectation(description: "Wait for request.")

        yummly.detailsRecipe(id: "Busy-Day-Soup-2553114") { (recipe) in
            XCTAssertNotNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    // Test if the getImage method works
    func testGetImageShouldReturnAnImage() {
        guard let imageUrl = URL(string: urlImage) else {return}

        let expectation = XCTestExpectation(description: "Wait for request.")

        yummly.getImage(url: imageUrl) { (image) in
            XCTAssertNotNil(image)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

}
