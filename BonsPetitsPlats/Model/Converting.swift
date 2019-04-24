
//
//  Converting.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 14/04/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation
import UIKit

class Convert {
    
    static func convertTime(time: Int) -> String {
        var quotien: Int = 0
        var reste: Int = 0
        if (time / 3600) != 0 {
            quotien = time / 3600
            if (time % 3600) != 0 {
                reste = (time % 3600) / 60
                return String(quotien) + "h" + String(reste)
            }
            return String(quotien) + "h"
        }
        return String(time / 60) + "m"
    }
    
    static func makeIngredientLine(text: [String]) -> String {
        var string: String = ""
        for e in text {
            string += ", " + e
        }
        string.removeFirst()
        return string
    }
    
    static func convertDetail(recipe: Recipe, image: UIImage, ingredient: String) -> Details {
        let id = recipe.id
        let url = recipe.smallImageUrls
        let name = recipe.recipeName
        let time = recipe.totalTimeInSeconds
        let rate = recipe.rating
        
        return Details(ingredients: ingredient, id: id, smallImageUrls: url, image: image, recipeName: name, totalTimeInSeconds: time, rating: rate)
    }
    
    static func convertDetail(recipe: RecipeP, image: UIImage, ingredient: String) -> Details {
        let id = recipe.id!
        //let url = recipe.url
        let name = recipe.name
        let time = recipe.time
        let rate = recipe.rate
        
        return Details(ingredients: ingredient, id: id, smallImageUrls: nil, image: image, recipeName: name!, totalTimeInSeconds: Int(time), rating: Int(rate))
    }
    
}
