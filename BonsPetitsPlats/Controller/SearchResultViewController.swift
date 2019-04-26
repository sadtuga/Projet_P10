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
            guard let list = listDetails?.ingredients else {return}
            guard let imageTemp = image else {return}
            let ingredient = Convert.makeIngredientList(text: list)
            recipDetails = Convert.convertDetail(recipe: listDetails!, image: imageTemp, ingredient: ingredient)
            guard let id = recipDetails?.id else {return}
            isFav = RecipeP.containsRecipe(id)
            refreshSreen()
        } else if favListDetails != nil {
            guard let list = favListDetails?.ingredients else {return}
            guard let imageTemp = image else {return}
            let ingredient = Convert.makeIngredientList(text: list)
            guard let recipe = Convert.convertDetail(recipe: favListDetails!, image: imageTemp, ingredient: ingredient) else {return}
            recipDetails = recipe
            guard let id = recipDetails?.id else {return}
            isFav = RecipeP.containsRecipe(id)
            refreshSreen()
        }
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        if isFav == false {
            guard let image = self.image else {return}
            guard let recipe = recipDetails else {return}
            RecipeP.save(recipe: recipe, image: image)
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
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
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
        guard let name = recipDetails?.recipeName else {return}
        guard let like = recipDetails?.rating else {return}
        guard let time = recipDetails?.totalTimeInSeconds else {return}
        guard let image = recipDetails?.image else {return}
        guard let ingredients = recipDetails?.ingredients else {return}
        
        self.name.text = name
        self.like.text = String(like)
        self.duration.text = Convert.convertTime(time: time)
        self.background.image = image
        ingredientList.text = ingredients
        modifieFavImage()
    }
 
}
