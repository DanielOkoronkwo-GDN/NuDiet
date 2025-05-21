import Testing
import ComposableArchitecture

@testable import ClientDomain

@MainActor
struct ClientDomainTests {

    @Test func basics() async throws {
        let store = TestStore(initialState: RecipeListDomain.State()) {
            RecipeListDomain()
        } withDependencies: { value in
           
        }

        let mockRecipes = [Recipe.sampleOne,Recipe.sampleTwo]
        
        let mockResponse = PaginatedResponse(
            recipes: mockRecipes,
            total: 2,
            skip: 0,
            limit: 2
        )
        
        store.dependencies.apiClient.fetchPage = { page, pageSize in
            return mockResponse
        }
        
        await store.send(.start)
        
        store.exhaustivity = .off
    
    }
    
    @Test("On clear selection")
    func userTappedClear() async throws {
        let store = TestStore(initialState: RecipeListDomain.State()) {
            RecipeListDomain()
        }
        
        await store.send(.clearSelection)
    }
    
    @Test("Clear filters")
    func userTappedClearFilter() async throws {
        let store = TestStore(initialState: RecipeListDomain.State()) {
            RecipeListDomain()
        }
        
        await store.send(.clearFilter)
    }
    

}

