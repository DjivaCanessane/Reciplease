//
//  RecipeCoreDataStack.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 11/12/2020.
//

import Foundation
import CoreData

class RecipeCoreDataStack {
    // MARK: - Properties

    private let modelName: String

    // MARK: - Initializer

    public init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Core Data stack

    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    public lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    public func saveContext() {
        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
