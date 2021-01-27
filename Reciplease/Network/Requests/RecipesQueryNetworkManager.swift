//
//  SearchRecipeNetworkManager.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 17/11/2020.
//

import Foundation
import Alamofire

class RecipesQueryNetworkManager {
    let alamoFireNetworkRequest: NetworkRequest

    init(networkRequest: NetworkRequest = AlamofireNetworkRequest()) {
        self.alamoFireNetworkRequest = networkRequest
    }

    func getRecipes(
        for ingredients: [String],
        callback: @escaping (Result<[DisplayableRecipe], NetworkError>) -> Void) {
        guard ingredients != [] else { return callback(.failure(.noIngredients)) }
        let queryUrl: URL = generateQueryURL(for: ingredients)
        alamoFireNetworkRequest.get(queryUrl) { (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
                guard let recipes = try? JSONDecoder().decode(Recipes.self, from: data) else {
                    return callback(.failure(.decodingError))
                }
                let fetchGroup = DispatchGroup()
                var displayableRecipes: [DisplayableRecipe] = []
                recipes.hits.forEach { (hit) in
                    self.getImage(for: hit, fetchGroup: fetchGroup) { displayableRecipes.append($0) }
                }
                fetchGroup.notify(queue: .main) {
                    callback(.success(displayableRecipes))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }

    func getImage(for hit: Hit, fetchGroup: DispatchGroup, callback: @escaping (DisplayableRecipe) -> Void) {
        fetchGroup.enter()
        let imageData: Data = UIImage(named: "foodImage")!.pngData()!
        let queryURL = URL(string: hit.recipe.image)
        self.alamoFireNetworkRequest.get(queryURL!) { (result: Result<Data, NetworkError>) in
            var displayableRecipe = DisplayableRecipe(
                imageData: imageData,
                imageURL: hit.recipe.image,
                recipeURL: hit.recipe.url,
                dishName: hit.recipe.label,
                yield: hit.recipe.yield,
                duration: hit.recipe.totalTime,
                ingredients: hit.recipe.ingredientLines
            )

            switch result {
            case .success(let data):
                displayableRecipe.imageData = data
                callback(displayableRecipe)
            case .failure:
                callback(displayableRecipe)
            }
            fetchGroup.leave()
        }
    }

    private func generateQueryURL(for ingredients: [String]) -> URL {
        var ingredientsStrList: String = ""
        let rawURL = String(
            format: "https://api.edamam.com/search?app_id=%@&app_key=%@",
            Constants.Id.edamamId,
            Constants.Keys.edamamKey
        )

        for ingredient in ingredients {
            ingredientsStrList = "\(ingredientsStrList)+\(ingredient)"
        }

        var queryUrl = URLComponents(
            string: rawURL
        )!
        queryUrl.queryItems?.append(URLQueryItem(name: "q", value: ingredientsStrList))
        queryUrl.queryItems?.append(URLQueryItem(name: "from", value: "0"))
        queryUrl.queryItems?.append(URLQueryItem(name: "to", value: "100"))
        return queryUrl.url!
    }
}
