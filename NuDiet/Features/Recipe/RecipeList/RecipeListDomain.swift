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
        var currentPage = 1
        var pageSize = 5
        var isLoading = false
        var hasMorePages = true
        var selectedRecipe: Recipe?
        var errorMessage: String?
    }
    
    // Response wrapper to handle both success and failure scenarios
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
    }
    
    // User or system-triggered actions handled by the reducer
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case .start:
            // Start loading recipes only if the list is currently empty
            guard state.items.isEmpty else { return .none }
            return .send(.fetchNextPage)
            
        case .didScrollToBottom:
            // Trigger next page load when user scrolls to bottom
            return .send(.fetchNextPage)
            
        case .fetchNextPage:
            // Prevent duplicate loads or loading past the final page
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
            // Append new recipes to the existing list and update pagination info
            state.items.append(contentsOf: response.recipes)
            state.currentPage += 1
            state.hasMorePages = response.currentPage < response.totalPages
            state.isLoading = false
            return .none
            
        case let .fetchResponse(.failure(errorMessage)):
            // Handle fetch error by showing message and stopping loading
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
        }
    }
}
