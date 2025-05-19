//
//  RecipeItem.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation

struct Recipe: Identifiable, Equatable {
    let id: Int
    let name: String
    let ingredients: [String]?
    let instructions: [String]?
    let prepTimeMinutes: Int?
    let cookTimeMinutes: Int?
    let servings: Int?
    let difficulty: String?
    let cuisine: String?
    let caloriesPerServing: Double?
    let tags: [String]?
    let image: String?
    let rating: Double?
    let reviewCount: Int?
    let mealType: [String]?
    
    public static func ==(lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }
}

extension Recipe: Decodable {
    private enum RecipeItemKey: String, CodingKey {
        case id
        case name
        case ingredients
        case instructions
        case prepTimeMinutes
        case cookTimeMinutes
        case servings
        case difficulty
        case cuisine
        case caloriesPerServing
        case tags
        case image
        case rating
        case reviewCount
        case mealType
    }
}


extension Recipe {
    
    static let sampleOne = Recipe(
        id: 1,
        name: "Classic Margherita Pizza",
        ingredients: [
            "Pizza dough",
            "Tomato sauce",
            "Fresh mozzarella cheese",
            "Fresh basil leaves",
            "Olive oil",
            "Salt and pepper to taste"
        ],
        instructions: [
            "Preheat the oven to 475°F (245°C).",
            "Roll out the pizza dough and spread tomato sauce evenly.",
            "Top with slices of fresh mozzarella and fresh basil leaves.",
            "Drizzle with olive oil and season with salt and pepper.",
            "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
            "Slice and serve hot."
        ],
        prepTimeMinutes: 20,
        cookTimeMinutes: 15,
        servings: 4,
        difficulty: "Easy",
        cuisine: "Italian",
        caloriesPerServing: 300,
        tags: [
            "Pizza",
            "Italian"
        ],
        image: "https://cdn.dummyjson.com/recipe-images/1.webp",
        rating: 4.6,
        reviewCount: 98,
        mealType: ["Dinner"]
    )
    
    static let sampleTwo = Recipe(
        id: 1,
        name: "Classic Margherita Pizza",
        ingredients: nil,
        instructions: nil,
        prepTimeMinutes: 20,
        cookTimeMinutes: 15,
        servings: 4,
        difficulty: nil,
        cuisine: "Italian",
        caloriesPerServing: 300,
        tags: [
            "Pizza",
            "Italian"
        ],
        image: nil,
        rating: 4.6,
        reviewCount: 98,
        mealType: ["Dinner"]
    )
    
}
