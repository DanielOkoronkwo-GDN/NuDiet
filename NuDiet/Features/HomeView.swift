//
//  HomeView.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
        
    @State private var showFilter: Bool = false
    
    @StateObject var store = StoreOf<RecipeListDomain>(
        initialState: RecipeListDomain.State(),
        reducer: RecipeListDomain.init
    )
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                welcomeTextContainer
                RecipeListView(store: store)
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationTitle("NuDiet")
            .navigationDestination(
                isPresented: Binding(
                    get: { store.selectedRecipe != nil },
                    set: { isPresented in
                        if !isPresented {
                            store.send(.clearSelection)
                        }
                    }
                ),
                destination: {
                    if let recipe = store.selectedRecipe {
                        RecipeDetailView(store: Store(initialState: RecipeDetailDomain.State(recipe: recipe)) {
                            RecipeDetailDomain()
                        })
                    }
                }
            ).toolbar {
                Button {
                    showFilter.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }.sheet(isPresented: $showFilter) {
                FilterView(store: store)
                    .presentationDetents([.fraction(0.44)])
            }.navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    @ViewBuilder
    var welcomeTextContainer: some View {
        Text("Discover new flavours and stay healthy.")
        .font(.system(size: 16, weight: .medium, design: .rounded))
        .padding(.horizontal)
    }

}

#Preview {
    HomeView()
}
