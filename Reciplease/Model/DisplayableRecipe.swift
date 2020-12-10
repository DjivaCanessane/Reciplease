//
//  Displayable.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 18/11/2020.
//

import Foundation

struct DisplayableRecipe {
    let imageData: Data
    let imageURL: String
    let recipeURL: String
    let dishName: String
    let yield: Double
    let duration: Int
    let ingredients: [String]
}
