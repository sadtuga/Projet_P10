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
    let get = GetImage()

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
        
        cell.configure(name: recipe.recipeName, ingredient: recipe.ingredients, time: recipe.totalTimeInSeconds, like: recipe.rating, background: nil)
        
        return cell
    }
}
