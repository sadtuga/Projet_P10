//
//  RecipesListTableViewCell.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 28/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

class RecipesListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var favorites: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ingredient: UILabel!
    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var time: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(name: String, ingredient: [String], time: Int, like: Int, background: UIImage?, isFav: Bool) {
        self.background.image = background
        self.like.text = String(like)
        self.time.text = Convert.convertTime(time: time)
        self.name.text = name.capitalized
        self.ingredient.text = addIngredient(ingredient: ingredient)
    }
    
    func configureFavImage(fav: Bool) {
        if fav == true {
            favorites.image = #imageLiteral(resourceName: "WhiteFavoriteAdd")
        } else if fav == false {
            favorites.image = #imageLiteral(resourceName: "White Favoite")
        }
    }
    
    private func addIngredient(ingredient: [String]) -> String {
        var option: String = ""
        for e in ingredient {
            option += e + ", "
        }
        
        if option != "" {
            option = option.replacingOccurrences(of: ", ", with: "")
        }
        
        return option
    }
    
}
