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
    
    private var yummlySession: URLSession // Stock a URLSessions
    private var task: URLSessionDataTask? // Stock a URLSessionsDataTask
    
    init(yummlySession: URLSession = URLSession(configuration: .default)) {
        self.yummlySession = yummlySession
    }
    
    // Send a request to the Yummly API and return this response
    func getReciteList(text: String, callback: @escaping (Bool, RecipeYummly?) -> Void) {
        task?.cancel()
        let q = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = URL(string: "https://api.yummly.com/v1/api/recipes?_app_id=60663c48&_app_key=8855b3f3dfde11bd74a54030f8017176&q=\(q)")!
        task = yummlySession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let recipes = try? JSONDecoder().decode(RecipeYummly.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                callback(true, recipes)
            }
        }
        task?.resume()
    }
    
}
