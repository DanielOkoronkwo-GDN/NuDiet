//
//  RecipeListDomain.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct RecipeListDomain : Sendable {
    
    public init() {}
    
    /// State representing the UI and business logic for the recipe list
    @ObservableState
    public struct State: Equatable {

        var allItems: [Recipe] = []             // All fetched recipes (unfiltered source of truth)
        var currentPage: Int                     // Current page index for pagination
        var pageSize: Int                      // Number of items per page
        var hasMorePages: Bool                 // If there are more pages to fetch
        var errorMessage: String? = nil         // Error message to show in UI
        
        public var isLoading: Bool                   // Whether a fetch operation is in progress
        public var selectedRecipe: Recipe? = nil       // Currently selected recipe (for detail view)
        public var items: [Recipe] = []                // Filtered recipes to display
        public var filterModel: FilterModel = FilterModel() // Model holding active filters (difficulty, rating)
        
        public init(allItems: [Recipe] = [],
                    items: [Recipe] = [],
                    currentPage: Int = 1,
                    pageSize: Int = 5,
                    isLoading: Bool = false,
                    hasMorePages: Bool = true,
                    filterModel: FilterModel = FilterModel() ) {
            self.allItems = allItems
            self.items = items
            self.currentPage = currentPage
            self.pageSize = pageSize
            self.isLoading = isLoading
            self.hasMorePages = hasMorePages
            self.filterModel = filterModel
        }
    }
    
    /// Enum to handle success/failure responses when fetching recipes
    public enum RecipeListResponse: Equatable {
        case success(PaginatedResponse)
        case failure(String)
    }
    
    @Dependency(\.apiClient) var apiClient
    
    /// All supported user/system-triggered actions
    public enum Action: Equatable {
        case start                        // Initial load
        case didScrollToBottom           // User reached bottom of list
        case fetchNextPage               // Load more data
        case fetchResponse(RecipeListResponse) // Result of fetch
        case card(recipe: Recipe, action: RecipeCardDomain.Action) // Card interaction
        case clearSelection              // Deselect selected recipe
        
        // Filter-related
        case clearFilter
        case applyFilter(filter: FilterModel)
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        
        /// Applies the current filter model to the provided recipe list
        func applyFilter(recipes: [Recipe]) -> [Recipe] {
            let selectedDifficulty = state.filterModel.difficultyLevels
                .filter { $0.isSelected }
                .map { $0.difficulty.rawValue.capitalized }

            return recipes.filter { recipe in
                // Skip difficulty check if no filters selected
                let difficultyMatches: Bool
                if selectedDifficulty.isEmpty {
                    difficultyMatches = true
                } else if let difficulty = recipe.difficulty?.capitalized {
                    difficultyMatches = selectedDifficulty.contains(difficulty)
                } else {
                    // difficulty is nil and filters are active → exclude this recipe
                    difficultyMatches = false
                }

                // Rating check with minimum rating logic
                let ratingFilter = state.filterModel.rating
                let ratingMatches: Bool
                if ratingFilter.isActive, let recipeRating = recipe.rating {
                    ratingMatches = ratingFilter.value.isGreaterThanOrEqualTo(recipeRating)
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
            return .none
            
        case let .card(recipe, .recipeTapped):
            state.selectedRecipe = recipe
            return .none
            
        case .clearSelection:
            state.selectedRecipe = nil
            return .none
            
        case .applyFilter(let filter):
            state.filterModel = filter
            state.items = applyFilter(recipes: state.allItems)
            return .none
            
        case .clearFilter:
            let allItemsCopy = state.allItems
            state.filterModel = FilterModel()
            state.items = applyFilter(recipes: allItemsCopy)
            return .none
        }
    }
}


extension Double {
    /// Safe comparison for floating-point numbers to account for rounding errors.    
    func isGreaterThanOrEqualTo(_ other: Double, epsilon: Double = 0.0001) -> Bool {
        return self + epsilon >= other
    }
}
