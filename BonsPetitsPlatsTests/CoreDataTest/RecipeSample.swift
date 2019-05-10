//
//  RecipeSample.swift
//  BonsPetitsPlatsTests
//
//  Created by Marques Lucas on 08/05/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation
import CoreData
@testable import BonsPetitsPlats

struct RecipesSampleTests {
    
    private static let imageDataTest = "DefaultImage.jpg".data(using: .utf8) as NSData?
    
    static func saveRecipeTest1(with context: NSManagedObjectContext) {
        let recipe = RecipeP(context: context)
        
        recipe.name = "Busy Day Soup"
        recipe.ingredients = "ground beef, onion soup mix, frozen vegetables, water, diced tomatoes, macaroni"
        recipe.rate = 4
        recipe.id = "Busy-Day-Soup-2553114"
        recipe.time = 5400
        recipe.image = imageDataTest as Data?
        
        try? context.save()
    }
    
    static func saveRecipeTest2(with context: NSManagedObjectContext) {
        let recipe = RecipeP(context: context)
        
        recipe.name = "Instant Pot Steak Soup"
        recipe.ingredients = "round steak, ground pepper, onion soup mix, Worcestershire sauce, beef broth, medium egg noodles"
        recipe.rate = 4
        recipe.id = "Instant-Pot-Steak-Soup-2621178"
        recipe.time = 3000
        recipe.image = imageDataTest as Data?
        
        try? context.save()
    }
    
    static func saveRecipeTest3(with context: NSManagedObjectContext) {
        let recipe = RecipeP(context: context)
        
        recipe.name = "Quick & Easy 4 Ingredient Broccoli Cheese Soup"
        recipe.ingredients = "broccoli, cream of chicken soup, milk, shredded cheddar cheese"
        recipe.rate = 4
        recipe.id = "Quick-_-Easy-4-Ingredient-Broccoli-Cheese-Soup-1873692"
        recipe.time = 900
        recipe.image = imageDataTest as Data?
        
        try? context.save()
    }
    
}
