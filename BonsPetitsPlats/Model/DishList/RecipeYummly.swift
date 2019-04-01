//
//  RecipeYummly.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 26/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation

struct RecipeYummly: Decodable {
    var matches: [Recipe]
}

struct Recipe: Decodable {
    var ingredients: [String]
    var id: String
    var smallImageUrls: [String]
    var recipeName: String
    var totalTimeInSeconds: Int
    var rating: Int
}
