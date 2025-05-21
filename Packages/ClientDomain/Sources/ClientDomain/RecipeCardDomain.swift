//
//  RecipeCardDomain.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct RecipeCardDomain {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable, Identifiable {
        public let id: Int
        let recipe: Recipe
        
        public init(id: Int, recipe: Recipe) {
            self.id = id
            self.recipe = recipe
        }
    }
    
    public enum Action: Equatable {
        case recipeTapped
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .recipeTapped:
            return .none
        }
    }
}

public extension RecipeCardDomain.State {
    
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
