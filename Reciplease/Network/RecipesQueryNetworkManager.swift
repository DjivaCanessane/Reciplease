//
//  SearchRecipeNetworkManager.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 17/11/2020.
//

import Foundation
import Alamofire

class RecipesQueryNetworkManager {
    
    func getRecipes(for ingredients: [String], callback: @escaping (Result<[Hit], Error>) -> Void) {
        let queryUrl: URL = generateQueryURL(for: ingredients)
        AF.request(queryUrl)
            .validate()
            .responseDecodable(of: Recipes.self) { (response) in
                if let recipes = response.value {
                    callback(.success(recipes.hits))
                } else if let requestError = response.error {
                    callback(.failure(requestError))
                } else {
                    callback(.failure(NetworkError.hasError))
                }
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
        return queryUrl.url!
    }
}
