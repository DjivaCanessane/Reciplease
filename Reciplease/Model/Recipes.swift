//
//  Recipes.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 17/11/2020.
//
import Foundation

// MARK: - Recipes
struct Recipes: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let url: String
    let shareAs: String
    let ingredientLines: [String]
    let totalTime: Float
    let yield: Double
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
}
