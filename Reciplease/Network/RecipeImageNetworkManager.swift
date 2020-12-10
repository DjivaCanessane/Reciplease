//
//  RecipeImageNetworkManager.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 18/11/2020.
//

import Foundation
import Alamofire

class RecipeImageNetworkManager {
    
    func getImages(for hits: [Hit], callback: @escaping (Result<[DisplayableRecipe], Error>) -> Void) {
        
        let fetchGroup = DispatchGroup()
        var displayableRecipes: [DisplayableRecipe] = []
        hits.forEach { (hit) in
            fetchGroup.enter()
            AF.request(hit.recipe.image).validate().responseDecodable(of: Data.self) { (response) in
            let displayableRecipe = DisplayableRecipe(
                imageData: response.data ?? UIImage(named: "foodImage")!.pngData()!,
                imageURL: hit.recipe.image,
                recipeURL: hit.recipe.url,
                dishName: hit.recipe.label,
                yield: hit.recipe.yield,
                duration: hit.recipe.totalTime,
                ingredients: hit.recipe.ingredientLines
            )
            displayableRecipes.append(displayableRecipe)
            fetchGroup.leave()
          }
        }
        
        fetchGroup.notify(queue: .main) {
            callback(.success(displayableRecipes))
        }
    }
}
