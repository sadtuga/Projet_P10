
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
    
    static func makeIngredientList(text: [String]) -> String {
        var list = ""
        for e in text {
            list += "- " + e + "\n"
        }
        return list
    }
    
    static func makeIngredientList(text: String) -> String {
        let list = text
        return list.replacingOccurrences(of: ", ", with: "\n- ")
    }
    
    static func convertDetail(recipe: RecipeP, image: UIImage, ingredient: String) -> Details? {
        guard let id = recipe.id else {print("CONVERT FAV ID");return nil}
        guard let name = recipe.name else {print("CONVERT FAV NAME");return nil}
        //guard let urlString = recipe.url else {print("CONVERT FAV URL");return nil}
        //guard let url = URL(string: urlString) else {print("CONVERT FAV URLSTRING");return nil}
        let time = recipe.time
        let rate = recipe.rate
        
        return Details(ingredients: ingredient, id: id, smallImageUrls: nil, image: image, recipeName: name, totalTimeInSeconds: Int(time), rating: Int(rate))
    }
    
}
