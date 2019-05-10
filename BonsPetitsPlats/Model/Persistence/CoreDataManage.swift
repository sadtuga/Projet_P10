//
//  CoreDataManage.swift
//  BonsPetitsPlats
//
//  Created by Marques Lucas on 06/05/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataManage {
    var coreDataStack: CoreDataStack { get set }
    var context: NSManagedObjectContext { get set }
}
