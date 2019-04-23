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
        if list?.matches.count == 0 || list == nil {
            result.isHidden = false
            activityIndicator.isHidden = true
            return 0
        }
        activityIndicator.isHidden = true
        return (list?.matches.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as? RecipesListTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = list!.matches[indexPath.row]
        
        yummly.getImage(url: recipe.smallImageUrls[0]) { (succes, image) in
            cell.configure(name: recipe.recipeName, ingredient: recipe.ingredients, time: recipe.totalTimeInSeconds, like: recipe.rating, background: image, isFav: self.isFav)
            
            self.tabImage.updateValue(image, forKey: recipe.id)
        }
        
        isFav = RecipeP.containsRecipe(self.list!.matches[indexPath.row].id)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listDetails = list?.matches[indexPath.row]
        image = tabImage[listDetails.id]
        self.performSegue(withIdentifier: "segueToDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let add = UIContextualAction(style: .normal, title: "Add Favorites") { (action, view, nil) in
            guard let image = self.tabImage[self.list!.matches[indexPath.row].id] else {return}
            RecipeP.save(recipe: self.list!.matches[indexPath.row], image: image)
        }
        return UISwipeActionsConfiguration(actions: [add])
    }
    
    private func makeIngredientList(test: [String]) -> String {
        var string: String = ""
        for e in test {
            string += "- " + e + "\n"
        }
        return string
    }
}
