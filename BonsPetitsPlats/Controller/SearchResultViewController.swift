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
    var favListDetails: RecipeP?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if listDetails != nil {
            refreshSreen(like: listDetails!.rating, duration: listDetails!.totalTimeInSeconds, name: listDetails!.recipeName)
            makeIngredientList(test: listDetails!.ingredients)
        }else if favListDetails != nil {
            refreshSreen(like:Int(favListDetails!.rate), duration: Int(favListDetails!.time), name: favListDetails!.name!)
            makeIngredientList(test: favListDetails!.ingredients!)
        }
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        let recipeDedails = RecipeP(context: AppDelegate.viewContext)
        recipeDedails.name = name.text
        recipeDedails.id = listDetails?.id
        recipeDedails.rate = Int64(like.text!)!
        recipeDedails.time = Int64(duration.text!)!
        recipeDedails.image = nil
        recipeDedails.ingredients = ingredientList.text
        try? AppDelegate.viewContext.save()
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapeGetDirectionsButton(_ sender: Any) {
        if let id = favListDetails?.id {
            print(id)
            guard let url = URL(string: "https://www.yummly.com/recipe/" + id) else { return }
            UIApplication.shared.open(url)
        }
        
    }
    
    private func refreshSreen(like: Int, duration: Int, name: String) {
        self.name.text = name
        self.like.text = String(like)
        self.duration.text = String(duration)
        self.background = nil
    }
    
    private func makeIngredientList(test: [String]) {
        for e in test {
            ingredientList.text += "- " + e + "\n"
        }
    }
    
    private func makeIngredientList(test: String) {
        ingredientList.text = favListDetails?.ingredients
    }
 
}
