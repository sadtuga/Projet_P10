//
//  FavoriteViewController.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 11/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var recipeList = RecipeP.all
    var favListDetails: RecipeP?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetails" {
            let successVC = segue.destination as! SearchResultViewController
            successVC.favListDetails = favListDetails
        }
    }

}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeFavCell") as? FavorisTableViewCell else {
            return UITableViewCell()
        }
        
        let test = recipeList[indexPath.row]
        
        cell.configure(name: test.name!, ingredient: test.ingredients!, time: Int(test.time), like: Int(test.rate), background: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favListDetails = recipeList[indexPath.row]
        self.performSegue(withIdentifier: "segueToDetails", sender: self)
    }
    
}
