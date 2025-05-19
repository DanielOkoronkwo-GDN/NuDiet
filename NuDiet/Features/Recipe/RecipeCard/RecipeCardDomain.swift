//
//  RecipeCardDomain.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RecipeCardDomain {
    
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: Int
        let recipe: Recipe
    }
    
    enum Action: Equatable {
        case recipeTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .recipeTapped:
            return .none
        }
    }
}

extension RecipeCardDomain.State {
    
    var cookTimeString: String {
        if let cookTimeMinutes = recipe.cookTimeMinutes {
            return "\(cookTimeMinutes) min"
        } else {
            return "N/A"
        }
    }
    
    var ratingsString: String {
        recipe.rating.map { String(format: "%.1f", $0) } ?? "N/A"
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
