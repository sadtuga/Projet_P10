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
}
