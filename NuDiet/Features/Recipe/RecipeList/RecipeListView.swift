//
//  ResultsView.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import SwiftUI
import ComposableArchitecture
import ClientDomain

struct RecipeListView: View {
  
    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
   
    private let store: StoreOf<RecipeListDomain>
    
    init(store: StoreOf<RecipeListDomain>) {
        self.store = store
    }
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack {
                    if store.items.isEmpty {
                        if store.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .tint(.accent)
                        } else {
                            Text("No recipes available")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(store.items) { recipe in
                                view(for: recipe)
                            }
                        }
                    }
                }
            }.onAppear {
                store.send(.start)
            }
        }
    }
    
    @ViewBuilder
    func view(for recipe: Recipe) -> some View {
        RecipeCardView(store: Store(initialState: RecipeCardDomain.State(id: recipe.id, recipe: recipe)) {
            RecipeCardDomain()
        })
        .onTapGesture {
            store.send(.card(recipe: recipe, action: .recipeTapped))
        }
        .onAppear {
            if recipe == store.items.last {
                store.send(.didScrollToBottom)
            }
        }
    }
}

#Preview {
    RecipeListView(store: Store(
        initialState: RecipeListDomain.State(
            items: [Recipe.sampleOne, Recipe.sampleTwo],
            currentPage: 2,
            pageSize: 5,
            isLoading: false,
            hasMorePages: true
        )
    ) {
        RecipeListDomain()
    })
}


