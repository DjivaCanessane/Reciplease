//
//  MockContextProviderStub.swift
//  RecipleaseTests
//
//  Created by Djiveradjane Canessane on 18/12/2020.
//

import Foundation
import CoreData
@testable import Reciplease

class MockContextProviderStub: ContextProvider {
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    var managedObjectContext: NSManagedObjectContext
    
    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] where T : NSFetchRequestResult {
        throw CoreDataError.fetchError
    }
    
    func save() throws {
        throw CoreDataError.saveError
    }
    
    func delete(_ object: NSManagedObject) {
        managedObjectContext.delete(object)
    }
    
}

class MockFetchContextProviderStub: ContextProvider {
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    var managedObjectContext: NSManagedObjectContext
    
    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] where T : NSFetchRequestResult {
        throw CoreDataError.fetchError
    }
    
    func save() throws {
        try managedObjectContext.save()
    }
    
    func delete(_ object: NSManagedObject) {
        managedObjectContext.delete(object)
    }
    
}

class MockSaveContextProviderStub: ContextProvider {
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    var managedObjectContext: NSManagedObjectContext
    
    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] where T : NSFetchRequestResult {
        try managedObjectContext.fetch(request)
    }
    
    func save() throws {
        throw CoreDataError.saveError
    }
    
    func delete(_ object: NSManagedObject) {
        managedObjectContext.delete(object)
    }
    
}

