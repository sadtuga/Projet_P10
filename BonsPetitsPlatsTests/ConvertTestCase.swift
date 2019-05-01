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

    func testGivenTotalTimeInSeconds_WhenIsConvertInHour_ThenReturnTheResult() {
        let time = Convert.convertTime(time: 5400)
        XCTAssertEqual(time, "1h30")
    }
    
    func testGivenAStringArray_WhenIsConvertInLine_ThenReturnTheResult() {
        let ingredientTab = ["ground beef","onion soup mix","frozen vegetables","water","diced tomatoes","macaroni"]
        let result = " ground beef, onion soup mix, frozen vegetables, water, diced tomatoes, macaroni"
        let ingredientLine = Convert.makeIngredientLine(text: ingredientTab)
        XCTAssertEqual(ingredientLine, result)
    }
    
    func testGivenAStringArray_WhenIsConvertInList_ThenReturnTheResult() {
        let ingredientTab = ["ground beef","onion soup mix","frozen vegetables","water","diced tomatoes","macaroni"]
        let result = "- ground beef\n- onion soup mix\n- frozen vegetables\n- water\n- diced tomatoes\n- macaroni\n"
        let ingredientList = Convert.makeIngredientList(text: ingredientTab)
        XCTAssertEqual(ingredientList, result)
    }

}
