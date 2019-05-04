//
//  Alert.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 04/05/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation

class Alert {
    
    // Send a notification
    static func notification(message: String) {
        let name = Notification.Name(message)
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }
}
