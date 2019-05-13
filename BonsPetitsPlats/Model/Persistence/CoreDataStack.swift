//
//  CoreDataStack.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 06/05/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    lazy var context: NSManagedObjectContext = {
        return self.contextContainer.viewContext
    }()
    
    // This internal property must be changed (overrided) only for tests purpose to change persistent store type
    lazy var contextContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: name)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // Saves the context in case it has changed
    func saveContext () {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
