
//
//  Converting.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 14/04/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation
import UIKit

class Convert {
    
    static func convertTime(time: Int) -> String {
        var quotien: Int = 0
        var reste: Int = 0
        if (time / 3600) != 0 {
            quotien = time / 3600
            if (time % 3600) != 0 {
                reste = (time % 3600) / 60
                return String(quotien) + "h" + String(reste)
            }
            return String(quotien) + "h"
        }
        return String(time / 60) + "m"
    }
    
    static func makeIngredientLine(text: [String]) -> String {
        var string: String = ""
        for e in text {
            string += ", " + e
        }
        string.removeFirst()
        return string
    }
    
    static func makeIngredientList(text: [String]) -> String {
        var list = ""
        for e in text {
            list += "- " + e + "\n"
        }
        return list
    }
    
}
