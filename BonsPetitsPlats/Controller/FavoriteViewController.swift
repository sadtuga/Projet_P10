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
    @IBOutlet weak var favLab: UILabel!
    
    var recipeList: [RecipeP]?
    var recipeIngredient: String?
    var recipeID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipeList = RecipeP.all
        guard let count = recipeList?.count else {return}
        hideMessage(count: count)
        tableView.reloadData()
    }
    
    private func hideMessage(count: Int) {
        if count == 0 {
            favLab.isHidden = false
            return
        }
        favLab.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetails" {
            let successVC = segue.destination as! SearchResultViewController
            successVC.recipeID = recipeID
            successVC.recipeIngredient = recipeIngredient
        }
    }

}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = recipeList?.count else {return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeFavCell") as? FavorisTableViewCell else {
            return UITableViewCell()
        }
        
        guard let recipe = recipeList?[indexPath.row] else {return UITableViewCell()}
        guard let image = recipe.image else {return UITableViewCell()}
        guard let ingredient = recipe.ingredients else {return UITableViewCell()}
        guard let name = recipe.name else {return UITableViewCell()}
        
        let like = Int(recipe.rate)
        let background = UIImage(data: image)
        let time = Convert.convertTime(time: Int(recipe.time))
        
        cell.configure(name: name, ingredient: ingredient, time: time, like: like, background: background)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = recipeList?[indexPath.row] else {return}
        recipeID = recipe.id
        recipeIngredient = recipe.ingredients
        self.performSegue(withIdentifier: "segueToDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDelegate.viewContext.delete(RecipeP.all[indexPath.row])
            recipeList?.remove(at: indexPath.row)
            try? AppDelegate.viewContext.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            guard let count = recipeList?.count else {return}
            hideMessage(count: count)
        }
    }
    
}
