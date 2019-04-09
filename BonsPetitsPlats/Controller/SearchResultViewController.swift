//
//  SearchResultViewController.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 11/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var ingredientList: UITextView!
    
    var listDetails: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        if listDetails != nil {
            refreshSreen(like: listDetails!.rating, duration: listDetails!.totalTimeInSeconds)
            makeIngredientList()
        }
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        let recipeDedails = RecipeP(context: AppDelegate.viewContext)
        recipeDedails.name = name.text
        recipeDedails.rate = Int64(like.text!)!
        recipeDedails.time = Int64(duration.text!)!
        recipeDedails.image = nil
        recipeDedails.ingredients = ingredientList.text
        try? AppDelegate.viewContext.save()
    }
    
    private func refreshSreen(like: Int, duration: Int) {
        self.name.text = listDetails?.recipeName
        self.like.text = String(like)
        self.duration.text = String(duration)
        self.background = nil
    }
    
    private func makeIngredientList() {
        for e in listDetails!.ingredients {
            ingredientList.text += "- " + e + "\n"
        }
    }
}
