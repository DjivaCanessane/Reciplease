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

    private let recipeCoreDataStack: RecipeCoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    ///Returns an array containing every RecipeData object saved in CoreData
    var all: [RecipeData] {
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        guard let recipeDatas = try? managedObjectContext.fetch(request) else {
            return []
        }
        return recipeDatas
    }

    // MARK: - Initializer

    init(recipeCoreDataStack: RecipeCoreDataStack) {
        self.recipeCoreDataStack = recipeCoreDataStack
        self.managedObjectContext = recipeCoreDataStack.viewContext
    }
    
    // MARK: - Manage Task Entity
    
    ///Creates and saves a RecipeData entity from a DisplayableRecipe object in CoreData
    func save(_ displayableRecipe: DisplayableRecipe) throws {
        let recipeData = RecipeData(context: managedObjectContext)
        recipeData.name = displayableRecipe.dishName
        recipeData.ingredients = displayableRecipe.ingredients
        recipeData.duration = Int16(displayableRecipe.duration)
        recipeData.recipeURL = displayableRecipe.recipeURL
        recipeData.yield = Int16(displayableRecipe.yield)
        recipeData.imageData = displayableRecipe.imageData
        do { try managedObjectContext.save() } catch { throw error }
    }

    ///Removes a specific RecipeData with the given url from Core Data
    func deleteRecipeData(withUrl url: String) throws {
        //Create a request to find RecipeData containing the given URL
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        request.predicate = NSPredicate(format: "recipeURL == %@", url)
        
        //trying to get those recipeData
        var RecipeDatasToRemove: [RecipeData]
        do { RecipeDatasToRemove = try managedObjectContext.fetch(request) } catch { throw error }
        
        //If there are such recipeData, we delete them
        RecipeDatasToRemove.forEach { managedObjectContext.delete($0) }
        do { try managedObjectContext.save() } catch { throw error }
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
        do { recipeDatas = try managedObjectContext.fetch(request)
        } catch { throw error }
        
        //Return wheather or no the recipe is favorite
        return recipeDatas.isEmpty ? false : true
    }
}
