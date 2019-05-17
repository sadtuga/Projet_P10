//
//  SearchResultViewController.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 11/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var ingredientList: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var labelErreur: UILabel!
    
    var coreDataStack: CoreDataStack!
    private lazy var recipeManage = RecipeManage(coreDataStack: coreDataStack, context: coreDataStack.context)
    
    var recipeID: String!
    var recipeIngredient: String!
    private var recipDetails: Recipe?
    private var image: UIImage?
    
    private let yummly = YummlyService()
    private var isFav: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        createObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.isHidden = false
        if recipeID != nil {
            getRecipeDetails()
        }
    }
    
    // Add or delete the recipe
    @IBAction func addToFavorite(_ sender: Any) {
        if isFav == false {
            guard let image = self.background.image else {print("ERREUR IMAGE FAV");return}
            guard let recipe = recipDetails else {print("ERREUR FAV");return}
            guard let ingredient = recipeIngredient else {print("ERREUR FAV Ingredient");return}
            recipeManage.save(recipe: recipe, image: image, recipeIngredient: ingredient)
            isFav = true
            modifieFavImage()
        } else {
            guard let id = recipDetails?.id else {return}
            let index = recipeManage.returnIndex(id: id)
            if index == -1 {return}
            recipeManage.delete(index: index)
            isFav = false
            modifieFavImage()
        }
    }
    
    // Redirects the user on safaris to show him the instructions for the recipe
    @IBAction func didTapeGetDirectionsButton(_ sender: Any) {
        guard let id = recipDetails?.id else {return}
        guard let url = URL(string: "https://www.yummly.com/recipe/" + id) else { return }
        
        UIApplication.shared.open(url)
    }
    
    // Starts a network call and interprets the received data
    private func getRecipeDetails() {
        guard let id = recipeID else {return}
        yummly.detailsRecipe(id: id) { (recipe) in
            if let details = recipe {
                self.recipDetails = details
                guard let id = self.recipDetails?.id else {print("ERREUR ID");return}
                self.isFav = self.recipeManage.containsRecipe(id)
                self.getRecipeImage()
                self.activityIndicator.isHidden = true
            } else {
                print("ERREUR DETAILS")
                self.networkError()
                self.activityIndicator.isHidden = true
                self.labelErreur.isHidden = false
                return
            }
        }
    }
    
    // Change the icon depending on whether the recipe is in favorites or not
    private func modifieFavImage() {
        if isFav == true {
            favoriteButton.setImage(#imageLiteral(resourceName: "WhiteFavoriteAdd"), for: UIControl.State.normal)
        } else if isFav == false {
            favoriteButton.setImage(#imageLiteral(resourceName: "White Favoite"), for: UIControl.State.normal)
        }
    }
    
    // Displays the elements that make up the controller display
    private func viewDetail() {
        viewDetails.isHidden = false
        ingredientList.isHidden = false
        getDirectionButton.isHidden = false
        ingredientLabel.isHidden = false
    }
    
    // Retrieve the image returned by the network call
    private func getRecipeImage() {
        guard let url = recipDetails?.smallImageUrls else {print("ERREUR URL GET IMAGE");return}
        yummly.getImage(url: url) { (image) in
            self.refreshSreen(image: image)
        }
    }
    
    // Update the display taking into account the parameters received
    private func refreshSreen(image: UIImage) {
        guard let name = self.recipDetails?.recipeName else {print("eurreur name");return}
        guard let like = self.recipDetails?.rating else {print("eurreur like");return}
        guard let time = self.recipDetails?.totalTimeInSeconds else {print("eurreur time");return}
        guard let ingredients = self.recipDetails?.ingredients else {print("eurreur ingredient");return}
        let imageDetails = image
        
        self.name.text = name
        self.like.text = String(like) + "/5"
        self.duration.text = Convert.convertTime(time: time)
        self.background.image = imageDetails
        self.ingredientList.text = ingredients
        self.modifieFavImage()
        self.viewDetail()
    }
 
}
