//
//  ListViewController.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 27/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var list: [Recipe]?
    var recipeIngredient: String?
    var recipeID: String!
    
    var yummly = YummlyService()
    var tabImage: [String:UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetails" {
            let successVC = segue.destination as! SearchResultViewController
            successVC.recipeID = recipeID
            successVC.recipeIngredient = recipeIngredient
        }
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = list?.count else {return 0}
        
        if count == 0 || list == nil {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as? RecipesListTableViewCell else {
            return UITableViewCell()
        }
        
        var isFav: Bool = false
        
        guard let recipe = list?[indexPath.row] else {return UITableViewCell()}
        guard let id = self.list?[indexPath.row].id else {return UITableViewCell()}
        guard let count = list?.count else {return UITableViewCell()}
        //guard let RecipeP(context: AppDelegate.viewContext) else {return}
        
        isFav = RecipeP.containsRecipe(id)
        let ingredient = recipe.ingredients
        
        if tabImage.count < count {
            guard let url = recipe.smallImageUrls else {print("ERREUR URL");return UITableViewCell()}
            yummly.getImage(url: url) { (succes, image) in
                cell.configure(name: recipe.recipeName, ingredient: ingredient, time: recipe.totalTimeInSeconds, like: recipe.rating, background: image, isFav: isFav)
                
                self.tabImage.updateValue(image, forKey: recipe.id)
            }
        } else {
            guard let background = tabImage[recipe.id] else {return UITableViewCell()}
            cell.configure(name: recipe.recipeName, ingredient: ingredient, time: recipe.totalTimeInSeconds, like: recipe.rating, background: background, isFav: isFav)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = list?[indexPath.row] else {return}
        recipeID = recipe.id
        recipeIngredient = recipe.ingredients
        self.performSegue(withIdentifier: "segueToDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let add = UIContextualAction(style: .normal, title: "Add Favorites") { (action, view, nil) in
            guard let image = self.tabImage[self.list![indexPath.row].id] else {return}
            guard let recipe = self.list?[indexPath.row] else {return}
            RecipeP.save(recipe: recipe, image: image)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as? RecipesListTableViewCell else {return}
            cell.configureFavImage(fav: true)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [add])
    }
    
}
