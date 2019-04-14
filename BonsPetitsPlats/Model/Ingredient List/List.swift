//
//  List.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 14/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation

class List {
    
    static let shared = List()
    private init() {}
    
    private(set) var list: [Ingredient] = []
    
    func addIngredient(ingredient: Ingredient) {
        list.append(ingredient)
    }
    
    func removeIngredient(index: Int) {
        list.remove(at: index)
    }
    
    func removeAll() {
        list.removeAll()
    }
    
    func listCount() -> Int {
        return list.count
    }
    
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
    
    func contains(_ text: String) -> Bool {
        for e in list {
            if e.name == text {
                return true
            }
        }
        return false
    }
    
}
