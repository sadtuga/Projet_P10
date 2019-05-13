//
//  yummlyService.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 26/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class YummlyService {
    
    var imagedetails: UIImage?
    
    // Download a list of recipes and return it using the callBack parameter
    func getReciteList(text: String, callback: @escaping (Bool, [Recipe]?) -> Void) {
        guard let q = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "https://api.yummly.com/v1/api/recipes?_app_id=60663c48&_app_key=8855b3f3dfde11bd74a54030f8017176&q=\(q)") else {return}
        
        AF.request(url).validate().responseJSON { response in
            guard let data = response.data, response.error == nil else {
                callback(false, nil)
                return
            }
            let recipe = self.jsonToRecipeList(data: JSON(data))
            callback(true, recipe)
        }
    }
    
    // Interprets the data received by the Yummly API and returns a recipe table
    private func jsonToRecipeList(data: JSON) -> [Recipe] {
        var recipes = [Recipe]()
        for match in data["matches"].arrayValue {
            recipes.append(updateRecipe(data: match, isDetails: false))
        }
        return recipes
    }
    
    // Download the recipe according to the received id
    func detailsRecipe(id: String, callback: @escaping (Recipe?) -> Void) {
        guard let url = URL(string: "https://api.yummly.com/v1/api/recipe/\(id)?_app_id=60663c48&_app_key=8855b3f3dfde11bd74a54030f8017176") else {return}
        AF.request(url).validate().responseJSON { response in
            guard let data = response.data, response.error == nil else {
                callback(nil)
                return
            }
            let recipeDetail = self.updateRecipe(data: JSON(data), isDetails: true)
            callback(recipeDetail)
        }
    }
    
    // Interprets the data received by the Yummly API and returns a recipe
    func updateRecipe(data: JSON, isDetails: Bool) -> Recipe {
        
        let id = data["id"].stringValue
        let rate = data["rating"].intValue
        let time = data["totalTimeInSeconds"].intValue
        var name = ""
        var ingredients: [String]
        var ingredientList: String = ""
        var url: URL? = nil
        
        if isDetails == true {
            if let urlTemp = data["images"][0]["hostedLargeUrl"].url {
                url = urlTemp
                ingredients = data["ingredientLines"].arrayValue.map{$0.stringValue}
                ingredientList = Convert.makeIngredientList(text: ingredients)
                name = data["name"].stringValue
            } else {print("ERREUR URL 1")}
        } else {
            if let urlTemp = URL(string: (data["smallImageUrls"][0].string?.replacingOccurrences(of: "=s90", with: ""))!) {
                url = urlTemp
                ingredients = data["ingredients"].arrayValue.map{$0.stringValue}
                ingredientList = Convert.makeIngredientLine(text: ingredients)
                name = data["recipeName"].stringValue
            } else {print("ERREUR URL 2")}
        }
        
        return Recipe(ingredients: ingredientList, id: id, smallImageUrls: url, recipeName: name, totalTimeInSeconds: time, rating: rate)
    }
    
    // Download the image corresponding to the recipe
    func getImage(url: URL, imageHandler: @escaping ((UIImage) -> ())) {
        AF.request(url).responseData (completionHandler: { (response) in
            guard let image = response.data, response.error == nil else {
                guard let imageDefault = UIImage(named: "DefaultImage.jpg") else {print("ERREUR IMAGE DEFAULT");return}
                imageHandler(imageDefault)
                return
            }
            guard let imageOut = UIImage(data: image) else {print("ERREUR IMAGE");return}
            imageHandler(imageOut)
        })
    }
    
}
