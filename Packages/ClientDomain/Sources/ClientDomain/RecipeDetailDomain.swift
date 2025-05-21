//
//  RecipeItemDetailDomain.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct RecipeDetailDomain {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        let recipe: Recipe
        
        public init(recipe: Recipe) {
            self.recipe = recipe
        }
    }
    
}

public extension RecipeDetailDomain.State {
    
    var cookTimeString: String {
        if let cookTimeMinutes = recipe.cookTimeMinutes {
            return "\(cookTimeMinutes) min"
        } else {
            return "N/A"
        }
    }
    
    var caloriesString: String {
        if let calories = recipe.caloriesPerServing {
            return String(format: "%.1fg", calories)
        } else {
            return "N/A"
        }
    }
    
    var ratingsString: String {
        recipe.rating.map { String(format: "%.1f", $0) } ?? "N/A"
    }
    
    var ingredients: [String] {
        recipe.ingredients ?? []
    }
    
    var instructions: [String] {
        recipe.instructions ?? []
    }
    
    var mealTypes: [String] {
        recipe.mealType ?? []
    }
    
    var cuisineString: String {
        recipe.cuisine ?? "N/A"
    }
    
    var difficultyString: String {
        recipe.difficulty ?? "N/A"
    }
    
    var recipeTitle: String {
        recipe.name
    }
    
    var imageUrlString: String {
        recipe.image ?? ""
    }
}
