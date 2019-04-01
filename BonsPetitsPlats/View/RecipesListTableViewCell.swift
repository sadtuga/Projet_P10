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
    @IBOutlet weak var favoritesButton: UIButton!
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
    
    func configure(name: String, ingredient: [String], time: Int, like: Int, background: UIImageView?) {
        self.background = background
        self.like.text = String(like)
        self.time.text = String(time)
        self.name.text = name
        //self.ingredient.text = ingredient
    }
}
