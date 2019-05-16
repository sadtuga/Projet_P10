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

    let list = List()

    // test the contains method if the list already contains the element
    func testGivenAnIngredient_WhenCheckThatItIsInTheList_ThenReturnTrueIfItIs() {
        let ingredient = Ingredient(name: "soup")
        list.addIngredient(ingredient: ingredient)
        let check = list.contains("soup")
        list.removeAll()
        XCTAssertTrue(check)
    }

    // test the contains method if the list does not contain the element
    func testGivenAnIngredient_WhenCheckThatItIsInTheList_ThenReturnFalseIfThisIsNot() {
        let ingredient = Ingredient(name: "meet")
        list.addIngredient(ingredient: ingredient)
        let check = list.contains("soup")
        list.removeAll()
        XCTAssertFalse(check)
    }

    // Test the createRequestOption method
    func testGivenTwoIngredients_WhenIsCreateOptionRequest_ThenReturnTheRequestOption() {
        let ingredient = Ingredient(name: "meet")
        list.addIngredient(ingredient: ingredient)
        let ingredientTwo = Ingredient(name: "soup")
        list.addIngredient(ingredient: ingredientTwo)

        let request = list.createRequestOption()
        XCTAssertEqual(request, "meet+soup")
        list.removeAll()
    }

    // Test the addIngredient and listCount method
    func testGivenTwoIngredients_WhenWeCountTheNumberOfIngredients_ThenReturnTheNumberOfIngredients() {
        let ingredient = Ingredient(name: "meet")
        list.addIngredient(ingredient: ingredient)
        let ingredientTwo = Ingredient(name: "soup")
        list.addIngredient(ingredient: ingredientTwo)

        let count = list.listCount()
        XCTAssertEqual(count, 2)
        list.removeAll()
    }

    // Test the removeIngredient method
    func testGivenTwoIngredients_WhenWeRemoveOneOfTheIngredients_ThenTheNumberOfIngredientsToReturnMustBeEqualToOne() {
        let ingredient = Ingredient(name: "meet")
        list.addIngredient(ingredient: ingredient)
        let ingredientTwo = Ingredient(name: "soup")
        list.addIngredient(ingredient: ingredientTwo)
        list.removeIngredient(index: 1)

        let count = list.listCount()
        XCTAssertEqual(count, 1)
        list.removeAll()
    }

}
