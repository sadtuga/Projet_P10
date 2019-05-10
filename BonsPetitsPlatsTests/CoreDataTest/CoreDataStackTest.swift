//
//  CoreDataStack.swift
//  BonsPetitsPlatsTests
//
//  Created by Marques Lucas on 08/05/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation
import CoreData
@testable import BonsPetitsPlats

class CoreDataStackTest: CoreDataStack {
    
    convenience init() {
        self.init(modelName: "RecipePlease")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        self.contextContainer = container
    }
    
}
