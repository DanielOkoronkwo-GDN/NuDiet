//
//  RecipeDetailView.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import SwiftUI
import ComposableArchitecture
import ClientDomain

struct RecipeDetailView: View {
    
    private let store: StoreOf<RecipeDetailDomain>
    
    public init(store: StoreOf<RecipeDetailDomain>) {
        self.store = store
    }
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                imageView
                VStack(alignment: .leading, spacing: 10) {
                    mealTypesView
                    titleView
                    infoView
                    ingredientsView
                    stepsView
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    @ViewBuilder
    var mealTypesView: some View {
        if store.mealTypes.isEmpty == false {
            HStack {
                ForEach(store.mealTypes, id: \.self) { mealType in
                    Text(mealType)
                        .foregroundStyle(.brown.opacity(0.7))
                        .fontWeight(.light)
                        .padding(.bottom, 4)
                }
            }
        } else {
            Text("N/A")
                .font(FontStyle.caption.font)
        }
    }
    
    @ViewBuilder
    var titleView: some View {
        Text(store.recipeTitle)
            .font(FontStyle.title.font)
            .padding(.bottom)
    }
    
    @ViewBuilder
    var infoView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
            InfoItemView(title: store.cookTimeString, subtitle: "Cook time")
            InfoItemView(title: store.difficultyString, subtitle: "Difficulty")
            InfoItemView(title: store.cuisineString, subtitle: "Cuisine")
            InfoItemView(title: store.caloriesString, subtitle: "Calories")
        }
        .font(FontStyle.regular.font)
        .padding(.bottom)
    }
    
    @ViewBuilder
    var ingredientsView: some View {
        Text("Ingredients")
            .font(FontStyle.headerOne.font)
        
        if store.ingredients.isEmpty == false {
            ForEach(store.ingredients, id: \.self) { item in
                Text( "· \(item)")
                    .font(FontStyle.caption.font)
            }
        } else {
            Text("N/A")
                .font(FontStyle.caption.font)
        }
    }
    
    @ViewBuilder
    var stepsView: some View {
        Text("Preparation")
            .font(FontStyle.headerOne.font)
            .padding(.top)
        
        if store.instructions.isEmpty == false {
            VStack {
                ForEach(store.instructions, id: \.self) { step in
                    Text(step)
                        .padding()
                        .frame(maxWidth: .infinity,  alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.brown.opacity(0.1))
                        )
                }
            }
        } else {
            Text("N/A")
                .font(FontStyle.caption.font)
        }
        
    }
    
    @ViewBuilder
    var imageView: some View {
        ZStack {
            CacheImageView(imageUrlString: store.imageUrlString)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text(store.ratingsString)
                            .font(FontStyle.body.font)
                    }
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 20).foregroundStyle(.yellow)
                    )
                }
            }
            .padding(12)
        }
    }
    
}

#Preview {
    RecipeDetailView(store: Store(initialState: RecipeDetailDomain.State(recipe: Recipe.sampleOne)) {
        RecipeDetailDomain()
    })
}

#Preview {
    RecipeDetailView(store: Store(initialState: RecipeDetailDomain.State(recipe: Recipe.sampleTwo)) {
        RecipeDetailDomain()
    })
}
