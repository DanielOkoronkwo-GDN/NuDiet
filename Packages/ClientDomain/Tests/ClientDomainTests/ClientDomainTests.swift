import Testing
import ComposableArchitecture

@testable import ClientDomain

@MainActor
struct ClientDomainTests {

    @Test("Test Start Operation")
    func startOperation() async throws {
        
        let client = APIClient.testValue
        
        let store = TestStore(initialState: RecipeListDomain.State()) {
            RecipeListDomain()
        } withDependencies: { dependency in
            dependency.apiClient = client
        }
        
        await store.send(.start)
        
        await store.receive(.fetchNextPage) {
            $0.isLoading = true
            $0.errorMessage = nil
        }
        
        await store.receive(.fetchResponse(.success(PaginatedResponse.mock))) {
            $0.allItems = PaginatedResponse.mock.recipes
            $0.items = PaginatedResponse.mock.recipes
            $0.currentPage = 2
            $0.hasMorePages = false
            $0.isLoading = false
        }
    }
    
    @Test("User tapped Clear selection")
    func clearSelection() async throws {
        let store = TestStore(initialState: RecipeListDomain.State()) {
            RecipeListDomain()
        }
        
        await store.send(.clearSelection)
    }
    
    @Test("User tapped Clear Filters")
    func clearFilters() async throws {
        let store = TestStore(
            initialState: RecipeListDomain.State(
                allItems: [Recipe.sampleOne, Recipe.sampleTwo],
                items: [Recipe.sampleOne],
                filterModel: FilterModel(
                    difficultyLevels: [DifficultyModel(isSelected: true, difficulty: .easy)],
                    rating: RatingModel(isActive: true, value: 4.5)
                )
            )) {
                RecipeListDomain()
            }

        await store.send(.clearFilter) {
            $0.filterModel = FilterModel()
            $0.items = [Recipe.sampleOne, Recipe.sampleTwo]
        }
    }
    
    @Test("User tapped recipe")
    func userTappedRecipeCard() async throws {
        
        let client = APIClient.testValue
        
        let store = TestStore(initialState: RecipeListDomain.State()) {
            RecipeListDomain()
        } withDependencies: { dependency in
            dependency.apiClient = client
        }
        
        await store.send(.card(recipe: Recipe.sampleOne, action: .recipeTapped)) {
            $0.selectedRecipe = Recipe.sampleOne
        }
    }
    
    @Test("Apply filters")
    func userAppliedFilters() async throws {
        let client = APIClient.testValue
        
        let filter = FilterModel(
            difficultyLevels: [
                DifficultyModel(isSelected: false, difficulty: .easy),
                DifficultyModel(isSelected: true, difficulty: .medium),
                DifficultyModel(isSelected: false, difficulty: .hard)
            ],
            rating: RatingModel(isActive: true, value: 4.7)
        )
        
        let store = TestStore(
            initialState: RecipeListDomain.State(
                allItems: [Recipe.sampleOne, Recipe.sampleTwo],
                filterModel: filter
            )) {
                RecipeListDomain()
            } withDependencies: { dependency in
                dependency.apiClient = client
            }
        
        
        await store.send(.applyFilter(filter: filter)) {
            $0.filterModel = filter
            $0.items = [Recipe.sampleTwo]
        }
    }
    
}

