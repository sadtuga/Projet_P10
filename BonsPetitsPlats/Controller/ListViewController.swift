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
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var list: RecipeYummly?
    var listDetails: Recipe!
    var image: UIImage!
    
    var yummly = YummlyService()
    
    var isFav: Bool = false
    var tabImage: [String:UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        result.isHidden = true
        activityIndicator.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetails" {
            let successVC = segue.destination as! SearchResultViewController
            successVC.listDetails = listDetails
            successVC.image = image
        }
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = list?.matches.count else {return 0}
        
        if count == 0 || list == nil {
            result.isHidden = false
            activityIndicator.isHidden = true
            return 0
        }
        activityIndicator.isHidden = true
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as? RecipesListTableViewCell else {
            return UITableViewCell()
        }
        
        guard let recipe = list?.matches[indexPath.row] else {return UITableViewCell()}
        guard let id = self.list?.matches[indexPath.row].id else {return UITableViewCell()}
        
        isFav = RecipeP.containsRecipe(id)
        let ingredient = Convert.makeIngredientLine(text: recipe.ingredients)
        
        if tabImage.count < (list?.matches.count)! {
            yummly.getImage(url: recipe.smallImageUrls[0]) { (succes, image) in
                cell.configure(name: recipe.recipeName, ingredient: ingredient, time: recipe.totalTimeInSeconds, like: recipe.rating, background: image, isFav: self.isFav)
                
                self.tabImage.updateValue(image, forKey: recipe.id)
            }
        } else {
            guard let background = tabImage[recipe.id] else {return UITableViewCell()}
            cell.configure(name: recipe.recipeName, ingredient: ingredient, time: recipe.totalTimeInSeconds, like: recipe.rating, background: background, isFav: self.isFav)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = list?.matches[indexPath.row] else {return}
        listDetails = recipe
        image = tabImage[listDetails.id]
        self.performSegue(withIdentifier: "segueToDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let add = UIContextualAction(style: .normal, title: "Add Favorites") { (action, view, nil) in
            guard let image = self.tabImage[self.list!.matches[indexPath.row].id] else {return}
            guard let recipe = self.list?.matches[indexPath.row] else {return}
            RecipeP.save(recipe: recipe, image: image)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as? RecipesListTableViewCell else {return}
            cell.configureFavImage(fav: true)
        }
        return UISwipeActionsConfiguration(actions: [add])
    }
    
}
