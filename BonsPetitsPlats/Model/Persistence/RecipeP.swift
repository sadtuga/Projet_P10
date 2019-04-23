//
//  RecipeP.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 09/04/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class RecipeP: NSManagedObject {
    
    static var all: [RecipeP] {
        let request: NSFetchRequest<RecipeP> = RecipeP.fetchRequest()
        guard let recipeList = try? AppDelegate.viewContext.fetch(request) else {
        return []
        }
        return recipeList
    }
    
    static func containsRecipe(_ element: String) -> Bool {
        for e in all {
            if e.id == element {
                return true
            }
        }
        return false
    }
    
    static func save(recipe: Recipe, image: UIImage) {
        let recipeDedails = RecipeP(context: AppDelegate.viewContext)
        recipeDedails.name = recipe.recipeName
        recipeDedails.id = recipe.id
        recipeDedails.rate = Int64(recipe.rating)
        recipeDedails.time = Int64(recipe.totalTimeInSeconds)
        let data = image.pngData()
        recipeDedails.image = data
        recipeDedails.ingredients = Convert.makeIngredientLine(text: recipe.ingredients)
        try? AppDelegate.viewContext.save()
    }
    
    static func save(recipe: Details, image: UIImage) {
        let recipeDedails = RecipeP(context: AppDelegate.viewContext)
        recipeDedails.name = recipe.recipeName
        recipeDedails.id = recipe.id
        recipeDedails.rate = Int64(recipe.rating)
        recipeDedails.time = Int64(recipe.totalTimeInSeconds)
        let data = image.pngData()
        recipeDedails.image = data
        recipeDedails.ingredients = recipe.ingredients
        try? AppDelegate.viewContext.save()
    }

    
}
//RecipeP().name
