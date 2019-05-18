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

    private var imagedetails: UIImage?
    
    let recipeListUrl = "https://api.yummly.com/v1/api/recipes"
    let recipeDetailsURL = "https://api.yummly.com/v1/api/recipe/"
    let idAndAppKey = "?_app_id=60663c48&_app_key=8855b3f3dfde11bd74a54030f8017176"

    // Download a list of recipes and return it using the callBack parameter
    func getReciteList(text: String, callback: @escaping (Bool, [Recipe]?) -> Void) {
        guard let q = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: recipeListUrl + idAndAppKey + "&q=" + q) else {return}

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
            recipes.append(updateRecipe(data: match))
        }
        return recipes
    }

    // Download the recipe according to the received id
    func detailsRecipe(id: String, callback: @escaping (Recipe?) -> Void) {
        guard let url = URL(string: recipeDetailsURL + id + idAndAppKey) else {return}
        AF.request(url).validate().responseJSON { response in
            guard let data = response.data, response.error == nil else {
                callback(nil)
                return
            }
            let recipeDetail = self.updateRecipeDetails(data: JSON(data))
            callback(recipeDetail)
        }
    }
    
    // Interprets the data received by the Yummly API and returns a recipe
    private func updateRecipe(data: JSON) -> Recipe {
        
        let id = data["id"].stringValue
        let rate = data["rating"].intValue
        let time = data["totalTimeInSeconds"].intValue
        let name = data["recipeName"].stringValue
        let ingredients: [String] = data["ingredients"].arrayValue.map{$0.stringValue}
        let ingredientList: String = Convert.makeIngredientLine(text: ingredients)
        var url: URL? = nil
        
        if let urlString = data["smallImageUrls"][0].string?.replacingOccurrences(of: "=s90", with: "") {
            url = URL(string: urlString)
        }
        
        return Recipe(ingredients: ingredientList, id: id, smallImageUrls: url, recipeName: name, totalTimeInSeconds: time, rating: rate)
    }
    
    // Interprets the data received by the Yummly API and returns a recipe
    private func updateRecipeDetails(data: JSON) -> Recipe {
        
        let id = data["id"].stringValue
        let rate = data["rating"].intValue
        let time = data["totalTimeInSeconds"].intValue
        let name = data["name"].stringValue
        let ingredients: [String] = data["ingredientLines"].arrayValue.map{$0.stringValue}
        let ingredientList: String = Convert.makeIngredientList(text: ingredients)
        var url: URL? = nil
        
        if let urlTemp = data["images"][0]["hostedLargeUrl"].url {
            url = urlTemp
        }
        
        return Recipe(ingredients: ingredientList, id: id, smallImageUrls: url, recipeName: name, totalTimeInSeconds: time, rating: rate)
    }

    // Download the image corresponding to the recipe
    func getImage(url: URL, callback: @escaping ((UIImage) -> ())) {
        AF.request(url).responseData (completionHandler: { (response) in
            guard let image = response.data, response.error == nil else {
                guard let imageDefault = UIImage(named: "DefaultImage.jpg") else {print("ERREUR IMAGE DEFAULT");return}
                callback(imageDefault)
                return
            }
            guard let imageOut = UIImage(data: image) else {print("ERREUR IMAGE");return}
            callback(imageOut)
        })
    }
}
