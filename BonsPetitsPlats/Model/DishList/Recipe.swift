//
//  Recipe.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 11/04/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation
import UIKit

// Stock information about a recipe
struct Recipe {
    var ingredients: String
    var id: String
    var smallImageUrls: URL?
    var recipeName: String
    var totalTimeInSeconds: Int
    var rating: Int
}
