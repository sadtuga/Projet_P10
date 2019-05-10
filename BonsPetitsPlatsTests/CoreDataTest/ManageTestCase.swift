//
//  ManageTestCase.swift
//  BonsPetitsPlatsTests
//
//  Created by Marques Lucas on 08/05/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import XCTest
import CoreData
@testable import BonsPetitsPlats

class RecipeManagerTestCase: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var recipeManage: RecipeManage!
    
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataStackTest()
        recipeManage = RecipeManage(coreDataStack: coreDataStack, context: coreDataStack.context)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGivenThreeRecipesSaved_WhenCallGetRecipes_ThenShouldGetThreeRecipes() {
        
        RecipesSampleTests.saveRecipeTest1(with: coreDataStack.context)
        RecipesSampleTests.saveRecipeTest2(with: coreDataStack.context)
        RecipesSampleTests.saveRecipeTest3(with: coreDataStack.context)
        
        let recipes = recipeManage.favoris
        
        XCTAssertEqual(recipes.count, 3)
    }
    
    func testGivenRecipeSaved_WhenGetFirstRecipeID_ThenRecipeIDShouldEqualToTestID() {
        
        RecipesSampleTests.saveRecipeTest2(with: coreDataStack.context)
        let testID = "Instant-Pot-Steak-Soup-2621178"
        
        let recipeID = recipeManage.favoris.first!.id
        
        XCTAssertEqual(recipeID, testID)
    }
    
    func testGivenNoRecipeSaved_WhenCallGetRecipes_ThenRecipesShouldBeEmpty() {
        
        let recipes = recipeManage.favoris
        
        XCTAssertTrue(recipes.isEmpty)
    }
    
    func testGivenRecipeCreation_WhenSaveTheRecipe_ThenReturnsTrueIfTheBackupSucceeded() {
        
        let recipe = Recipe(ingredients: "lemon, cream cheese", id: "Lemon-Icebox-Pie-2718913", smallImageUrls: nil, image: nil, recipeName: "Lemon Icebox Pie",  totalTimeInSeconds: 600, rating: 0)
        let image = UIImage(named: "DefaultImage.jpg")!
        
        recipeManage.save(recipe: recipe, image: image)
        let fav = recipeManage.containsRecipe(recipe.id)
        
        XCTAssertTrue(fav)
    }
    
    func testGivenRecipeCreation_WhenSaveTheRecipeDetails_ThenReturnsTrueIfTheBackupSucceeded() {
        let recipe = Recipe(ingredients: "lemon, cream cheese", id: "Lemon-Icebox-Pie-2718913", smallImageUrls: nil, image: nil, recipeName: "Lemon Icebox Pie", totalTimeInSeconds: 600, rating: 0)
        let image = UIImage(named: "DefaultImage.jpg")!
        let ingredients = "lemon, apple"
        recipeManage.save(recipe: recipe, image: image, recipeIngredient: ingredients)
        let fav = recipeManage.containsRecipe(recipe.id)
        
        XCTAssertTrue(fav)
    }
    
    func testGivenTheAdditionOfThreeRecipeToFavorites_WhenWeCheckTheIndexOfTheRecipe_ThenReturnIndex() {
        RecipesSampleTests.saveRecipeTest1(with: coreDataStack.context)
        RecipesSampleTests.saveRecipeTest2(with: coreDataStack.context)
        RecipesSampleTests.saveRecipeTest3(with: coreDataStack.context)
        
        let index = recipeManage.returnIndex(id: "Instant-Pot-Steak-Soup-2621178")
        let indexTwo = recipeManage.returnIndex(id: "test")
        
        XCTAssertEqual(index, 2)
        XCTAssertEqual(indexTwo, -1)
    }
    
    func testGivenTheAdditionOfARecipeToFavorites_WhenWeCheckIfItIsInTheFavorites_ThenReturnTrueIfThatTheCase() {
        RecipesSampleTests.saveRecipeTest2(with: coreDataStack.context)
        
        let contain = recipeManage.containsRecipe("test")
        let containTwo = recipeManage.containsRecipe("Instant-Pot-Steak-Soup-2621178")
        
        XCTAssertFalse(contain)
        XCTAssertTrue(containTwo)
    }
    
}
