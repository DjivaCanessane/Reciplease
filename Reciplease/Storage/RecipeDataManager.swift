//
//  RecipeDataManager.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 04/12/2020.
//

import Foundation
import CoreData

class RecipeDataManager {
    ///Returns an array containing every RecipeData object saved in CoreData
    static var all: [RecipeData] {
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        guard let recipeDatas = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return recipeDatas
    }
    
    ///Creates and saves a RecipeData entity from a DisplayableRecipe object in CoreData
    func save(_ recipe: DisplayableRecipe) throws {
        let recipeData = RecipeData(context: AppDelegate.viewContext)
        recipeData.name = recipe.dishName
        recipeData.ingredients = recipe.ingredients
        recipeData.duration = Int16(recipe.duration)
        recipeData.recipeURL = recipe.recipeURL
        recipeData.yield = Int16(recipe.yield)
        recipeData.imageData = recipe.imageData
        do { try AppDelegate.viewContext.save() } catch { throw error }
    }

    ///Removes a specific RecipeData with the given url from Core Data
    func deleteRecipeData(withUrl url: String) throws {
        //Create a request to find RecipeData containing the given URL
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        
        //trying to get those recipeData
        var RecipeDatasToRemove: [RecipeData]
        do { RecipeDatasToRemove = try AppDelegate.viewContext.fetch(request) } catch { throw error }
        
        //If there are such recipeData, we delete them
        RecipeDatasToRemove.forEach { AppDelegate.viewContext.delete($0) }
        do { try AppDelegate.viewContext.save() } catch { throw error }
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
        do { recipeDatas = try AppDelegate.viewContext.fetch(request)
        } catch { throw error }
        
        //Return wheather or no the recipe is favorite
        return recipeDatas.isEmpty ? false : true
    }
}
