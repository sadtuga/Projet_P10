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
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var context: NSManagedObjectContext = {
        return self.contextContainer.viewContext
    }()
    
    lazy var contextContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext () {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
