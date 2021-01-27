//
//  ContextProvider.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 17/12/2020.
//

import Foundation
import CoreData

protocol ContextProvider {
    var managedObjectContext: NSManagedObjectContext { get }

    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T]
    func save() throws
    func delete(_ object: NSManagedObject)
}
