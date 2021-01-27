//
//  MockCoreDataStack.swift
//  RecipleaseTests
//
//  Created by Djiveradjane Canessane on 16/12/2020.
//

@testable import Reciplease
import CoreData

class MockCoreDataStack: RecipeCoreDataStack {

    // MARK: - Initializer

    convenience init() {
        self.init(modelName: "Reciplease")
    }

    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
}
