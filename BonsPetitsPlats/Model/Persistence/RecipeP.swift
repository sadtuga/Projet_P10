//
//  RecipeP.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 09/04/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation
import CoreData

class RecipeP: NSManagedObject {
    
    static var all: [RecipeP] {
        let request: NSFetchRequest<RecipeP> = RecipeP.fetchRequest()
        guard let recipeList = try? AppDelegate.viewContext.fetch(request) else {
        return []
        }
        return recipeList
    }
}
//RecipeP().name
