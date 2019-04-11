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
    
    let yummly = YummlyService()
    var list: RecipeYummly!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    @IBAction func didTapeAddButton(_ sender: Any) {
        guard textField.text != nil else {
            return
        }
        
        let ingredient = Ingredient(name: textField.text!)
        
        List.shared.addIngredient(ingredient: ingredient)
        tableView.reloadData()
        textField.text = nil
        activateClearButton()
    }
    
    @IBAction func didClearButton(_ sender: Any) {
        List.shared.removeAll()
        textField.text = nil
        tableView.reloadData()
        desableClearButton()
    }
    
    @IBAction func didTapeSearchButton(_ sender: Any) {
        let option = List.shared.createRequestOption()
        
        guard option != "" else {
            return
        }
        
        yummly.getReciteList(text: option) { (succes, recites) in
            self.list = recites
            self.performSegue(withIdentifier: "segueToList", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToList" {
            let successVC = segue.destination as! ListViewController
            successVC.list = list
        }
    }
    
    private func activateClearButton() {
        clearButton.isEnabled = true
        clearButton.backgroundColor = #colorLiteral(red: 0.2656526566, green: 0.5825412273, blue: 0.3644076288, alpha: 1)
    }
    
    private func desableClearButton() {
        clearButton.isEnabled = false
        clearButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
}

extension RecipleaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return List.shared.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Ingredients", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = List.shared.list[indexPath.row]
        
        cell.configure(name: ingredient.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            List.shared.removeIngredient(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}

