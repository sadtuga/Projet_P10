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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var recipeID: String!
    var recipeIngredient: String!
    var recipDetails: Details?
    var image: UIImage?
    
    let yummly = YummlyService()
    
    var isFav: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.isHidden = false
        if recipeID != nil {
            yummly.detailsRecipe(id: recipeID) { (succes, details) in
                if let detailsT = details {
                    self.recipDetails = detailsT
                    guard let id = self.recipDetails?.id else {print("ERREUR ID");return}
                    self.isFav = RecipeP.containsRecipe(id)
                    self.refreshSreen()
                    self.activityIndicator.isHidden = true
                } else {
                    print("ERREUR DETAILS")
                }
            }
        }
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        if isFav == false {
            guard let image = self.background.image else {print("ERREUR IMAGE FAV");return}
            guard let recipe = recipDetails else {print("ERREUR FAV");return}
            guard let ingredient = recipeIngredient else {print("ERREUR FAV Ingredient");return}
            RecipeP.save(recipe: recipe, image: image, recipeIngredient: ingredient)
            isFav = true
            modifieFavImage()
        } else {
            guard let id = recipDetails?.id else {return}
            let index = RecipeP.returnIndex(id: id)
            AppDelegate.viewContext.delete(RecipeP.all[index])
            try? AppDelegate.viewContext.save()
            isFav = false
            modifieFavImage()
        }
    }
    
    @IBAction func didTapeGetDirectionsButton(_ sender: Any) {
        guard let id = recipDetails?.id else {return}
        guard let url = URL(string: "https://www.yummly.com/recipe/" + id) else { return }
        
        UIApplication.shared.open(url)
    }
    
    private func modifieFavImage() {
        if isFav == true {
            favoriteButton.setImage(#imageLiteral(resourceName: "WhiteFavoriteAdd"), for: UIControl.State.normal)
        } else if isFav == false {
            favoriteButton.setImage(#imageLiteral(resourceName: "White Favoite"), for: UIControl.State.normal)
        }
    }
    
    private func refreshSreen() {
        guard let url = recipDetails?.smallImageUrls else {print("ERREUR URL GET IMAGE");return}
        yummly.getImage(url: url) { (succes, image) in
            
            guard let name = self.recipDetails?.recipeName else {print("eurreur name");return}
            guard let like = self.recipDetails?.rating else {print("eurreur like");return}
            guard let time = self.recipDetails?.totalTimeInSeconds else {print("eurreur time");return}
            guard let ingredients = self.recipDetails?.ingredients else {print("eurreur ingredient");return}
            let imageDetails = image
            
            self.name.text = name
            self.like.text = String(like)
            self.duration.text = Convert.convertTime(time: time)
            self.background.image = imageDetails
            self.ingredientList.text = ingredients
            self.modifieFavImage()
        }
    }
 
}
