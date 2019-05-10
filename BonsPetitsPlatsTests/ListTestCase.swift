//
//  ListTestCase.swift
//  BonsPetitsPlatsTests
//
//  Created by Marques Lucas on 01/05/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import XCTest
@testable import BonsPetitsPlats

class ListTestCase: XCTestCase {

    func testGivenAnIngredient_WhenCheckThatItIsInTheList_ThenReturnTrueIfItIs() {
        let ingredient = Ingredient(name: "soup")
        List.shared.addIngredient(ingredient: ingredient)
        let check = List.shared.contains("soup")
        List.shared.removeAll()
        XCTAssertTrue(check)
    }
    
    func testGivenAnIngredient_WhenCheckThatItIsInTheList_ThenReturnFalseIfThisIsNot() {
        let ingredient = Ingredient(name: "meet")
        List.shared.addIngredient(ingredient: ingredient)
        let check = List.shared.contains("soup")
        List.shared.removeAll()
        XCTAssertFalse(check)
    }
    
    func testGivenTwoIngredients_WhenIsCreateOptionRequest_ThenReturnTheRequestOption() {
        let ingredient = Ingredient(name: "meet")
        List.shared.addIngredient(ingredient: ingredient)
        let ingredientTwo = Ingredient(name: "soup")
        List.shared.addIngredient(ingredient: ingredientTwo)
        
        let request = List.shared.createRequestOption()
        XCTAssertEqual(request, "meet+soup")
        List.shared.removeAll()
    }
    
    func testGivenTwoIngredients_WhenWeCountTheNumberOfIngredients_ThenReturnTheNumberOfIngredients() {
        let ingredient = Ingredient(name: "meet")
        List.shared.addIngredient(ingredient: ingredient)
        let ingredientTwo = Ingredient(name: "soup")
        List.shared.addIngredient(ingredient: ingredientTwo)
        
        let count = List.shared.listCount()
        XCTAssertEqual(count, 2)
        List.shared.removeAll()
    }
    
    func testGivenTwoIngredients_WhenWeRemoveOneOfTheIngredients_ThenTheNumberOfIngredientsToReturnMustBeEqualToOne() {
        let ingredient = Ingredient(name: "meet")
        List.shared.addIngredient(ingredient: ingredient)
        let ingredientTwo = Ingredient(name: "soup")
        List.shared.addIngredient(ingredient: ingredientTwo)
        List.shared.removeIngredient(index: 1)
        
        let count = List.shared.listCount()
        XCTAssertEqual(count, 1)
        List.shared.removeAll()
    }

}
