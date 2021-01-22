//
//  Displayable.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 18/11/2020.
//

import Foundation

struct DisplayableRecipe: Equatable {
    var imageData: Data
    let imageURL: String
    let recipeURL: String
    let dishName: String
    let yield: Double
    let duration: Float
    let ingredients: [String]
}
