//
//  List.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 14/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation

class List {
    
    // Stock the ingredients entered by the user
    private(set) var list: [Ingredient] = []
    
    // Add an ingredient to the list
    func addIngredient(ingredient: Ingredient) {
        list.append(ingredient)
    }
    
    // Deletes an ingredient from the list array
    func removeIngredient(index: Int) {
        list.remove(at: index)
    }
    
    // Remove all the ingredients from the list array
    func removeAll() {
        list.removeAll()
    }
    
    // Return the number of items in the list array
    func listCount() -> Int {
        return list.count
    }
    
    // Created the query parameter using the list array
    func createRequestOption() -> String {
        var option: String = ""
        for e in list {
            option += e.name + "+"
        }
        
        if option != "" {
            let index = option.lastIndex(of: "+")!
            option.remove(at: index)
        }
        
        return option
    }
    
    // Returns true if the list array contains the element received as a parameter
    func contains(_ text: String) -> Bool {
        for e in list {
            if e.name == text {
                return true
            }
        }
        return false
    }
    
}
