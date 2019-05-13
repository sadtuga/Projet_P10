//
//  ListTableViewCell.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 24/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(name: String) {
        self.name.text = "- " + name
    }

}
