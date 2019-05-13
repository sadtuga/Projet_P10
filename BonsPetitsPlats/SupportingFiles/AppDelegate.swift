//
//  AppDelegate.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 11/03/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var coreDataStack = CoreDataStack(name: "RecipePlease")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let tabBarController = window?.rootViewController as? UITabBarController,
            let tabViewControllers = tabBarController.viewControllers,
            let RecipleaseViewController = tabViewControllers[0] as? UINavigationController,
            let favoriteController = tabViewControllers[1] as? UINavigationController else {return true}
        
        
        if let RecipleaseViewVC = RecipleaseViewController.topViewController as? RecipleaseViewController {
            RecipleaseViewVC.coreDataStack = coreDataStack
        }
        
        if let favoriteViewVC = favoriteController.topViewController as? FavoriteViewController {
            favoriteViewVC.coreDataStack = coreDataStack
        }
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    
}
