//
//  FavorisTableViewCell.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 25/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

class FavorisTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroud: UIImageView!
    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ingredient: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
