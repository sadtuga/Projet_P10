//
//  yummlyService.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 26/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation
import Alamofire

class YummlyService {

    // Send a request to the Yummly API and return this response
    func getReciteList(option: String, callBack: @escaping (Bool, RecipeYummly?) -> Void) {
        let url = "https://api.yummly.com/v1/api/recipes?_app_id=60663c48&_app_key=8855b3f3dfde11bd74a54030f8017176&q=\(option)"
        AF.request(url).responseData { response in
            guard let data = response.data, response.error == nil else {
                callBack(false, nil)
                return
            }
            guard let recipes = try? JSONDecoder().decode(RecipeYummly.self, from: data) else {
                callBack(false, nil)
                return
            }
                
            callBack(true, recipes)
            return
        }
    }
    
    func getImage(url: String, imageHandler: @escaping ((Bool, UIImage?) -> ())) {
        
        AF.request(url).responseData (completionHandler: { (response) in
            //debugPrint(response)
            guard let image = response.data, response.error == nil else {
                imageHandler(false, nil)
                return
            }
            let imageOut = UIImage(data: image)!
            imageHandler(true, imageOut)
        })
    }
    
}
