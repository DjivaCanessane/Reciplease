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
    static let recipeDataManager = RecipeDataManager()
}
