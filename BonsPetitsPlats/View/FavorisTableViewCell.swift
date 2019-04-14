//
//  FavorisTableViewCell.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 25/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

class FavorisTableViewCell: UITableViewCell {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(name: String, ingredient: String, time: Int, like: Int, background: UIImageView?) {
        self.name.text = name
        self.ingredients.text = ingredient
        self.duration.text = Convert.convertTime(time: time)
        self.like.text = String(like)
    }

}
