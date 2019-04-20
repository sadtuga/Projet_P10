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
    var recipDetails: Details?
    var image: UIImage?
    
    var isFav: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if listDetails != nil {
            makeIngredientList(test: listDetails!.ingredients)
            recipDetails = Details(ingredients: ingredientList.text, id: listDetails!.id, smallImageUrls: listDetails!.smallImageUrls, image: image, recipeName: listDetails!.recipeName, totalTimeInSeconds: listDetails!.totalTimeInSeconds, rating: listDetails!.rating)
            isFav = RecipeP.containsRecipe(recipDetails!.id)
            refreshSreen()
        }else if favListDetails != nil {
            recipDetails = Details(ingredients: ingredientList.text, id: favListDetails!.id!, smallImageUrls: nil, image: image, recipeName: favListDetails!.name!, totalTimeInSeconds: Int(favListDetails!.time), rating: Int(favListDetails!.rate))
            isFav = RecipeP.containsRecipe(recipDetails!.id)
            refreshSreen()
            makeIngredientList(test: favListDetails!.ingredients!)
        }
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        let recipeDedails = RecipeP(context: AppDelegate.viewContext)
        recipeDedails.name = recipDetails?.recipeName
        recipeDedails.id = recipDetails?.id
        recipeDedails.rate = Int64(recipDetails!.rating)
        recipeDedails.time = Int64(listDetails!.totalTimeInSeconds)
        recipeDedails.ingredients = ingredientList.text
        /*guard self.image == nil else {
            return
        }*/
        let data = image!.pngData()
        recipeDedails.image = data
        try? AppDelegate.viewContext.save()
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapeGetDirectionsButton(_ sender: Any) {
        if let id = recipDetails?.id {
            guard let url = URL(string: "https://www.yummly.com/recipe/" + id) else { return }
            UIApplication.shared.open(url)
        }
        
    }
    
    private func modifieFavImage() {
        if isFav == true {
            favoriteButton.imageView?.image = #imageLiteral(resourceName: "WhiteFavoriteAdd")
        } else if isFav == false {
            favoriteButton.imageView?.image = #imageLiteral(resourceName: "White Favoite")
        }
    } 
    
    private func refreshSreen() {
        self.name.text = recipDetails?.recipeName
        self.like.text = String(recipDetails!.rating)
        self.duration.text = Convert.convertTime(time: recipDetails!.totalTimeInSeconds)
        self.background.image = recipDetails?.image
        modifieFavImage()
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
