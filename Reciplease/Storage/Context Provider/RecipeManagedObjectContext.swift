//
//  RecipeManagedObjectContext.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 17/12/2020.
//

import Foundation
import CoreData

class RecipeManagedObjectContext: ContextProvider {
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    var managedObjectContext: NSManagedObjectContext
    
    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] where T : NSFetchRequestResult {
        try managedObjectContext.fetch(request)
    }
    
    func save() throws {
        try managedObjectContext.save()
    }
    
    func delete(_ object: NSManagedObject) {
        managedObjectContext.delete(object)
    }
    
}
