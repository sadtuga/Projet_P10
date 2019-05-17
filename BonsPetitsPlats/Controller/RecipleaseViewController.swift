//
//  RecipleaseViewController.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 11/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

class RecipleaseViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var coreDataStack: CoreDataStack!
    var recipeList: [Recipe]!
    private let yummly = YummlyService()
    private let list = List()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        enableButton()
    }
    
    // Hide the keyboard
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    // Add an ingredient to the list
    @IBAction func didTapeAddButton(_ sender: Any) {
        guard let text = textField?.text else {return}
        guard textField.text != nil, list.contains(text) == false else {
            return
        }
        guard text.count >= 1 else {
            return
        }
        
        let ingredient = Ingredient(name: text)
        
        list.addIngredient(ingredient: ingredient)
        tableView.reloadData()
        textField.text = nil
        activateClearButton()
    }
    
    // Clears the ingredient list
    @IBAction func didTapeClearButton(_ sender: Any) {
        list.removeAll()
        textField.text = nil
        tableView.reloadData()
        desableClearButton()
    }
    
    // Starts the search and displays the ListViewController if the search is successful
    @IBAction func didTapeSearchButton(_ sender: Any) {
        let option = list.createRequestOption()
        desableButton()
        
        if option == "" {
            enableButton()
            return
        }
        
        yummly.getReciteList(text: option) { (succes, recipe) in
            if succes == true {
                self.recipeList = recipe
                self.performSegue(withIdentifier: "segueToList", sender: self)
            } else {
                self.networkError()
                self.enableButton()
            }
        }
    }
    
    // Prepares the transition to ListViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToList" {
            guard let successVC = segue.destination as? ListViewController else {return} 
            successVC.list = recipeList
            successVC.coreDataStack = coreDataStack
        }
    }
    
    // Disable the search button
    private func desableButton() {
        activityIndicator.isHidden = false
        searchButton.isEnabled = false
        searchButton.backgroundColor = #colorLiteral(red: 0.503008008, green: 0.5034076571, blue: 0.5030698776, alpha: 1)
    }
    
    // Enable the search button
    private func enableButton() {
        activityIndicator.isHidden = true
        searchButton.isEnabled = true
        searchButton.backgroundColor = #colorLiteral(red: 0.2677764595, green: 0.5841065049, blue: 0.3664145768, alpha: 1)
    }
    
    // Enable the clear button
    private func activateClearButton() {
        clearButton.isEnabled = true
        clearButton.backgroundColor = #colorLiteral(red: 0.2656526566, green: 0.5825412273, blue: 0.3644076288, alpha: 1)
    }
    
    // Disable the clear button
    private func desableClearButton() {
        clearButton.isEnabled = false
        clearButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
}

extension RecipleaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Return the section number of the UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Return the number of ingredient in the list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.list.count
    }
    
    // Configure and display UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Ingredients", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = list.list[indexPath.row]
        
        cell.configure(name: ingredient.name)
        
        return cell
    }
    
    // Removes an ingredient from the list by dragging the UITableViewCell to the left
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.removeIngredient(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if list.listCount() == 0 {
                desableClearButton()
            }
        }
    }
    
    
}

