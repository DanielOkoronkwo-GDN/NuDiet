//
//  NuDietTests.swift
//  NuDietTests
//
//  Created by Daniel Okoronkwo on 20/05/2025.
//

import Testing
import ComposableArchitecture

@testable import NuDiet

@MainActor
struct NuDietTests {

    @Test func basics() async throws {
        let store = TestStore(initialState: RecipeListDomain.State()) {
            RecipeListDomain()
        }

        let mockRecipes = [Recipe.sampleOne,Recipe.sampleTwo]
        
        let mockResponse = PaginatedResponse(
            recipes: mockRecipes,
            total: 2,
            skip: 0,
            limit: 2
        )
        
        store.dependencies.apiClient.fetchPage = { page, pageSize in
            #expect(page == 1)
            #expect(pageSize == 5)
            return mockResponse
           
        }
        await store.send(.start)
        await store.skipReceivedActions()
    }
    
    @Test("On clear selection")
    func userTappedClear() async throws {
        let store = TestStore(initialState: RecipeListDomain.State()) {
            RecipeListDomain()
        }
        
        await store.send(.clearSelection) {
            $0.selectedRecipe = nil
        }
    }
    
    @Test("Clear filters")
    func userTappedClearFilter() async throws {
        let store = TestStore(initialState: RecipeListDomain.State()) {
            RecipeListDomain()
        }
        
        let mockRecipes = [Recipe.sampleOne,Recipe.sampleTwo]
        
        let mockResponse = PaginatedResponse(
            recipes: mockRecipes,
            total: 2,
            skip: 0,
            limit: 2
        )
        
        store.dependencies.apiClient.fetchPage = { page, pageSize in
            #expect(page == 1)
            #expect(pageSize == 5)
            return mockResponse
           
        }
        
        await store.send(.clearFilter) {
            $0.filterModel = FilterModel()
         //   $0.items = mockRecipes
        }
    }
    

}

