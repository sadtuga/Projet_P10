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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(name: String, ingredient: String, time: String, like: String, background: UIImage?, isFav: Bool) {
        self.background.image = background
        self.like.text = like + "/5"
        self.time.text = time
        self.name.text = name
        self.ingredient.text = ingredient
        configureFavImage(fav: isFav)
    }
    
    // Change the icon depending on whether the recipe is in favorites or not
    func configureFavImage(fav: Bool) {
        if fav == true {
            favorites.image = #imageLiteral(resourceName: "WhiteFavoriteAdd")
        } else if fav == false {
            favorites.image = #imageLiteral(resourceName: "White Favoite")
        }
    }
    
}
