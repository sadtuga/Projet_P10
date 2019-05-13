//
//  Recipe.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 06/05/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class RecipeManage: CoreDataManage {
    
    var coreDataStack: CoreDataStack
    var context: NSManagedObjectContext
    
    init(coreDataStack: CoreDataStack, context: NSManagedObjectContext) {
        self.coreDataStack = coreDataStack
        self.context = context
    }
    
    // Returns the list of all Recipes to present in list
    var favoris: [RecipeP] {
        let request: NSFetchRequest<RecipeP> = RecipeP.fetchRequest()
        do {
            let recipes = try context.fetch(request)
            return recipes
        } catch let error as NSError {
            print("Error to get recipes: \n \(error) \n User Info Error —> \(error.userInfo)")
            return []
        }
    }
    
    // Returns true if the received item is in the favorites table
    func containsRecipe(_ element: String) -> Bool {
        for e in favoris {
            if e.id == element {
                return true
            }
        }
        return false
    }
    
    // Return index corresponding to received id
    func returnIndex(id: String) -> Int {
        var index = 0
        for e in favoris {
            if e.id == id {
                return index
            }
            index += 1
        }
        return -1
    }
    
    // Saves the recipe received in the iphone's memory
    func save(recipe: Recipe, image: UIImage) {
        guard containsRecipe(recipe.id) == false else {return}
        let recipeDedails = RecipeP(context: context)
        recipeDedails.name = recipe.recipeName
        recipeDedails.id = recipe.id
        recipeDedails.rate = Int64(recipe.rating)
        recipeDedails.time = Int64(recipe.totalTimeInSeconds)
        let data = image.pngData()
        recipeDedails.image = data
        recipeDedails.ingredients = recipe.ingredients
        do {
            try context.save()
        } catch let error as NSError {
            print("Detailed recipe saving error: \n \(error) \n User Info Error —> \(error.userInfo)")
        }
    }
    
    // Saves the recipe received in the iphone's memory
    func save(recipe: Recipe, image: UIImage, recipeIngredient: String) {
        guard containsRecipe(recipe.id) == false else {return}
        let recipeDedails = RecipeP(context: context)
        recipeDedails.name = recipe.recipeName
        recipeDedails.id = recipe.id
        recipeDedails.rate = Int64(recipe.rating)
        recipeDedails.time = Int64(recipe.totalTimeInSeconds)
        let data = image.pngData()
        recipeDedails.image = data
        recipeDedails.ingredients = recipeIngredient
        do {
            try context.save()
        } catch let error as NSError {
            print("Detailed recipe saving error: \n \(error) \n User Info Error —> \(error.userInfo)")
        }
    }
    
    // Deletes the recipe based on the received index
    func delete(index: Int) {
        context.delete(favoris[index])
        do {
            try context.save()
        } catch let error as NSError {
            print("Detailed recipe saving error: \n \(error) \n User Info Error —> \(error.userInfo)")
        }
    }
}
