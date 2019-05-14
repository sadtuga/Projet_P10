//
//  ListViewController.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 27/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coreDataStack: CoreDataStack!
    private lazy var recipeManage = RecipeManage(coreDataStack: coreDataStack, context: coreDataStack.context)
    
    
    var list: [Recipe]?
    var recipeIngredient: String?
    var recipeID: String!
    
    private var yummly = YummlyService()
    private var tabImage: [String:UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObserver()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // Prepares the transition to SearchResultViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetails" {
            let successVC = segue.destination as! SearchResultViewController
            successVC.recipeID = recipeID
            successVC.recipeIngredient = recipeIngredient
            successVC.coreDataStack = coreDataStack
        }
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Return the section number of the UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Return the number of recipes return by the Yummly API
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = list?.count else {return 0}
        
        if count == 0 || list == nil {
            return 0
        }
        return count
    }
    
    // Configure and display UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as? RecipesListTableViewCell else {
            return UITableViewCell()
        }
        
        var isFav: Bool = false
        
        guard let recipe = list?[indexPath.row] else {return UITableViewCell()}
        guard let id = self.list?[indexPath.row].id else {return UITableViewCell()}
        guard let count = list?.count else {return UITableViewCell()}
        guard let timeTemp = list?[indexPath.row].totalTimeInSeconds else {return UITableViewCell()}
        let time = Convert.convertTime(time: timeTemp)
        let rate = String(recipe.rating)
        
        isFav = recipeManage.containsRecipe(id)
        let ingredient = recipe.ingredients
        
        if tabImage.count < count {
            guard let url = recipe.smallImageUrls else {print("ERREUR URL");return UITableViewCell()}
            yummly.getImage(url: url) { (image) in
                cell.configure(name: recipe.recipeName, ingredient: ingredient, time: time, like: rate, background: image, isFav: isFav)
                self.tabImage.updateValue(image, forKey: recipe.id)
            }
        } else {
            guard let background = tabImage[recipe.id] else {return UITableViewCell()}
            cell.configure(name: recipe.recipeName, ingredient: ingredient, time: time, like: rate, background: background, isFav: isFav)
        }
        
        return cell
    }
    
    // Switch to the SearchResultViewController view by selecting a UITableViewCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = list?[indexPath.row] else {return}
        recipeID = recipe.id
        recipeIngredient = recipe.ingredients
        self.performSegue(withIdentifier: "segueToDetails", sender: self)
    }
    
    // Adds a recipe to favorites by dragging the UITableViewCell to the left
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let add = UIContextualAction(style: .normal, title: "Add Favorites") { (action, view, nil) in
            guard let id = self.list?[indexPath.row].id else {return}
            guard let image = self.tabImage[id] else {return}
            guard let recipe = self.list?[indexPath.row] else {return}
            self.recipeManage.save(recipe: recipe, image: image)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as? RecipesListTableViewCell else {return}
            cell.configureFavImage(fav: true)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [add])
    }
    
}
