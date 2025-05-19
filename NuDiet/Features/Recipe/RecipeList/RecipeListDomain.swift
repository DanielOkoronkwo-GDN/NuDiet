//
//  RecipeListDomain.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RecipeListDomain {
    
    @ObservableState
    struct State: Equatable {
        var items: [Recipe] = []
        var allItems: [Recipe] = [] // Source of truth for all fetched data
        var currentPage = 1
        var pageSize = 5
        var isLoading = false
        var hasMorePages = true
        var selectedRecipe: Recipe?
        var errorMessage: String?
        
        var filterModel: FilterModel = FilterModel()
    }
    
    enum RecipeListResponse: Equatable {
        case success(PaginatedResponse)
        case failure(String)
    }
    
    @Dependency(\.apiClient) var apiClient
    
    enum Action: Equatable {
        case start
        case didScrollToBottom
        case fetchNextPage
        case fetchResponse(RecipeListResponse)
        case card(recipe: Recipe, action: RecipeCardDomain.Action)
        case clearSelection
        
        case clearFilter
        case applyFilter
        case updateRating(rating: Double)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        
        func applyFilter(recipes: [Recipe]) -> [Recipe] {
            let selectedDifficulty = state.filterModel.difficultyLevels
                .filter { $0.isSelected }
                .map { $0.difficulty.rawValue.capitalized }

            return recipes.filter { recipe in
                // Difficulty matching (default to Easy if missing)
                let difficultyMatches = selectedDifficulty.isEmpty ||
                    selectedDifficulty.contains(recipe.difficulty?.capitalized ?? "Easy")
                
                // Rating filtering
                let ratingFilter = state.filterModel.rating
                let ratingMatches: Bool
                if ratingFilter.isActive,
                   let filterValue = ratingFilter.value,
                   let recipeRating = recipe.rating {
                    ratingMatches = recipeRating <= filterValue
                } else {
                    ratingMatches = true
                }

                return difficultyMatches && ratingMatches
            }
        }
        
        func clearFilters(state: inout State) {
            state.filterModel = FilterModel()
            state.items = applyFilter(recipes: state.allItems)
        }
        
        switch action {
            
        case .start:
            guard state.items.isEmpty else { return .none }
            return .send(.fetchNextPage)
            
        case .didScrollToBottom:
            return .send(.fetchNextPage)
            
        case .fetchNextPage:
            guard !state.isLoading, state.hasMorePages else { return .none }
            state.isLoading = true
            state.errorMessage = nil
            return .run { [page = state.currentPage, pageSize = state.pageSize] send in
                do {
                    let response = try await apiClient.fetchPage(page, pageSize)
                    await send(.fetchResponse(.success(response)))
                } catch {
                    await send(.fetchResponse(.failure(error.localizedDescription)))
                }
            }
            
        case let .fetchResponse(.success(response)):
            state.allItems.append(contentsOf: response.recipes)
            state.items = applyFilter(recipes: state.allItems)
            state.currentPage += 1
            state.hasMorePages = response.currentPage < response.totalPages
            state.isLoading = false
            return .none
            
        case let .fetchResponse(.failure(errorMessage)):
            state.isLoading = false
            state.errorMessage = errorMessage
            print("Error: \(errorMessage)")
            return .none
            
        case let .card(recipe, .recipeTapped):
            state.selectedRecipe = recipe
            return .none
            
        case .clearSelection:
            state.selectedRecipe = nil
            return .none
            
        case .applyFilter:
            state.items = applyFilter(recipes: state.allItems)
            return .none
            
        case .clearFilter:
            let allItemsCopy = state.allItems
            state.filterModel = FilterModel()
            state.items = applyFilter(recipes: allItemsCopy)
            return .none
            
        case .updateRating(let rating):
            state.filterModel.rating = RatingModel(isActive: true, value: rating)
            state.items = applyFilter(recipes: state.allItems)
            return .none
        }
    }
}
