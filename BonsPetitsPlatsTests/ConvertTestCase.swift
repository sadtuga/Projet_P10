//
//  ConvertTestCase.swift
//  BonsPetitsPlatsTests
//
//  Created by Marques Lucas on 01/05/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import XCTest
@testable import BonsPetitsPlats

class ConvertTestCase: XCTestCase {

    // Test the conversion of temp in seconds to hour
    func testGivenTotalTimeInSeconds_WhenIsConvertInHour_ThenReturnTheResult() {
        let time = Convert.convertTime(time: 5400)
        let timeTwo = Convert.convertTime(time: 3600)
        let timeThree = Convert.convertTime(time: 1800)
        XCTAssertEqual(time, "1h30")
        XCTAssertEqual(timeTwo, "1h")
        XCTAssertEqual(timeThree, "30m")
    }

    // Test the conversion of a string array as a line
    func testGivenAStringArray_WhenIsConvertInLine_ThenReturnTheResult() {
        let ingredientTab = ["ground beef", "onion soup mix", "frozen vegetables", "water", "diced tomatoes", "macaroni"]
        let result = " ground beef, onion soup mix, frozen vegetables, water, diced tomatoes, macaroni"
        let ingredientLine = Convert.makeIngredientLine(text: ingredientTab)
        XCTAssertEqual(ingredientLine, result)
    }

    // Test the conversion of a string array as a list
    func testGivenAStringArray_WhenIsConvertInList_ThenReturnTheResult() {
        let ingredientTab = ["ground beef", "onion soup mix", "frozen vegetables", "water", "diced tomatoes", "macaroni"]
        let result = "- ground beef\n- onion soup mix\n- frozen vegetables\n- water\n- diced tomatoes\n- macaroni\n"
        let ingredientList = Convert.makeIngredientList(text: ingredientTab)
        XCTAssertEqual(ingredientList, result)
    }

}
