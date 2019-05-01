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
    
    private var yummlySession: URLSession // Stock a URLSessions
    private var task: URLSessionDataTask? // Stock a URLSessionsDataTask
    
    var imagedetails: UIImage?
    
    init(yummlySession: URLSession = URLSession(configuration: .default)) {
        self.yummlySession = yummlySession
    }
    
    // Send a request to the Yummly API and return this response
    func getReciteList(text: String, callback: @escaping (Bool, [Recipe]?) -> Void) {
        task?.cancel()
        let q = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = URL(string: "https://api.yummly.com/v1/api/recipes?_app_id=60663c48&_app_key=8855b3f3dfde11bd74a54030f8017176&q=\(q)")!
        
        AF.request(url).validate().responseJSON { response in
            guard let data = response.data, response.error == nil else {
                callback(false, nil)
                return
            }
            let recipe = self.jsonToRecipeList(data: JSON(data))
            callback(true, recipe)
        }
        task?.resume()
    }
    
    private func jsonToRecipeList(data: JSON) -> [Recipe] {
        var recipes = [Recipe]()
        for match in data["matches"].arrayValue {
            recipes.append(updateRecipe(data: match, test: false))
        }
        return recipes
    }
    
    func detailsRecipe(id: String, callback: @escaping (Bool, Recipe?) -> Void) {
        task?.cancel()
        let url = URL(string: "https://api.yummly.com/v1/api/recipe/\(id)?_app_id=60663c48&_app_key=8855b3f3dfde11bd74a54030f8017176")!
        AF.request(url).validate().responseJSON { response in
            guard let data = response.data, response.error == nil else {
                callback(false, nil)
                return
            }
            let recipeDetail = self.updateRecipe(data: JSON(data), test: true)
            callback(true, recipeDetail)
        }
        task?.resume()
    }
    
    func updateRecipe(data: JSON, test: Bool) -> Recipe {

        let id = data["id"].stringValue
        let rate = data["rating"].intValue
        let time = data["totalTimeInSeconds"].intValue
        var name = ""
        var ingredients: [String]
        var ingredientList: String = ""
        var url: URL? = nil
        
        if test == true {
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
        
        
        return Recipe(ingredients: ingredientList, id: id, smallImageUrls: url, image: nil, recipeName: name, totalTimeInSeconds: time, rating: rate)
    }
    
    func getImage(url: URL, imageHandler: @escaping ((Bool, UIImage) -> ())) {
        AF.request(url).responseData (completionHandler: { (response) in
            guard let image = response.data, response.error == nil else {
                guard let imageDefault = UIImage(named: "DefaultImage.jpg") else {print("ERREUR IMAGE DEFAULT");return}
                print("ERREUR DL IMAGE")
                imageHandler(false, imageDefault)
                return
            }
            guard let imageOut = UIImage(data: image) else {print("ERREUR IMAGE");return}
            imageHandler(true, imageOut)
        })
    }
    
}
