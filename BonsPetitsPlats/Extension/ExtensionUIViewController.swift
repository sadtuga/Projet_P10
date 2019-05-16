//
//  ExtensionController.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 04/05/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Create an observer for each notification
    func createObserver() {
        let firstNotif = Notification.Name(rawValue: "NetworkError")
        NotificationCenter.default.addObserver(self, selector: #selector(networkError), name: firstNotif, object: nil)
    }

    // Show a custom alert based on title and message received
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

    // Display a network alert
    @objc func networkError() {
        alert(title: "NetworkError", message: "A network error occurred to verify your connection!")
    }

    // Display a network alert
    @objc func networkImageError() {
        alert(title: "NetworkError", message: "An error occurred while uploading the image")
    }
}
