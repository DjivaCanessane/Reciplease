//
//  ServiceContainer.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 17/11/2020.
//

import Foundation

struct ServiceContainer {
    static let alertManager = AlertManager()
    static let recipeQueryNetworkManager = RecipesQueryNetworkManager()
    static let recipeImageNetworkManager = RecipeImageNetworkManager()
    static let recipeCoreDataStack = RecipeCoreDataStack(modelName: "Reciplease")
    static let recipeDataManager = RecipeDataManager(recipeCoreDataStack: recipeCoreDataStack)
}
