//
//  FavoriteViewController.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 11/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var recipeList: [RecipeP]?
    var favListDetails: RecipeP?
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipeList = RecipeP.all
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetails" {
            let successVC = segue.destination as! SearchResultViewController
            successVC.favListDetails = favListDetails
            successVC.image = image
        }
    }

}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeFavCell") as? FavorisTableViewCell else {
            return UITableViewCell()
        }
        
        guard let recipe = recipeList?[indexPath.row] else {return UITableViewCell()}
        guard let image = recipe.image else {return UITableViewCell()}
        guard let ingredient = recipe.ingredients else {return UITableViewCell()}
        
        let background = UIImage(data: image)
        let time = Convert.convertTime(time: Int(recipe.time))
        let ingredientList = Convert.makeIngredientLine(text: ingredient)
        
        cell.configure(name: recipe.name!, ingredient: ingredientList, time: time, like: Int(recipe.rate), background: background)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = recipeList?[indexPath.row] else {return}
        guard let imageTemp = UIImage(data: recipeList![indexPath.row].image!) else {return}
        favListDetails = recipe
        image = imageTemp
        self.performSegue(withIdentifier: "segueToDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDelegate.viewContext.delete(RecipeP.all[indexPath.row])
            recipeList?.remove(at: indexPath.row)
            try? AppDelegate.viewContext.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
