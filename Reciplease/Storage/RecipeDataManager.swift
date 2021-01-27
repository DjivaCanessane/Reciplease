//
//  RecipeDataManager.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 04/12/2020.
//

import Foundation
import CoreData

class RecipeDataManager {
    // MARK: - Properties

    private let context: ContextProvider

    ///Returns an array containing every RecipeData object saved in CoreData
    var all: [RecipeData] {
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        guard let recipeDatas = try? context.fetch(request) else {
            return []
        }
        return recipeDatas
    }

    // MARK: - Initializer

    init(contextProvider: ContextProvider) {
        self.context = contextProvider
    }

    // MARK: - Manage Task Entity

    ///Creates and saves a RecipeData entity from a DisplayableRecipe object in CoreData
    func save(_ displayableRecipe: DisplayableRecipe) throws {
        let recipeData = RecipeData(context: context.managedObjectContext)
        recipeData.name = displayableRecipe.dishName
        recipeData.imageURL = displayableRecipe.imageURL
        recipeData.duration = displayableRecipe.duration
        recipeData.recipeURL = displayableRecipe.recipeURL
        recipeData.yield = Int16(displayableRecipe.yield)
        recipeData.imageData = displayableRecipe.imageData

        /*
         Here we force try displayableRecipe.ingredients encoding into binaryData,
         because neither recipeData.ingredient is optional in CoreData,
         and displayableRecipe.ingredients is not an optional
        */
        //swiftlint:disable:next force_try
        recipeData.ingredients = try! JSONEncoder().encode(displayableRecipe.ingredients)
        do { try context.save() } catch { throw CoreDataError.saveError }
    }

    ///Removes a specific RecipeData with the given url from Core Data
    func deleteRecipeData(withUrl url: String) throws {
        //Create a request to find RecipeData containing the given URL
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        request.predicate = NSPredicate(format: "recipeURL == %@", url)

        //trying to get those recipeData
        var recipeDatasToRemove: [RecipeData]
        do { recipeDatasToRemove = try context.fetch(request) } catch { throw CoreDataError.fetchError }

        //we delete them
        recipeDatasToRemove.forEach { context.delete($0) }
        do { try context.save() } catch { throw CoreDataError.saveError }
    }

    ///Returns a Bool whether the Recipe is favorite according to its presence or not in CoreData
    func isFavorite(recipeUrl url: String) throws -> Bool {
        //Create a request to find RecipeData containing the given URL
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        request.predicate = NSPredicate(format: "recipeURL == %@", url)

        //Prevent from getting Faults items in request instead of nothing
        request.returnsObjectsAsFaults = false

        //Trying to get those recipes
        var recipeDatas: [RecipeData] = []
        do { recipeDatas = try context.fetch(request)
        } catch { throw CoreDataError.fetchError }

        //Return wheather or no the recipe is favorite
        return recipeDatas.isEmpty ? false : true
    }
}
