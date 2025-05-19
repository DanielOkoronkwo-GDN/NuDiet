//
//  RecipeCardView.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import SwiftUI
import ComposableArchitecture

struct RecipeCardView: View {
    
    let store: StoreOf<RecipeCardDomain>
    
    var body: some View {
        WithPerceptionTracking {
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    imageView
                    title
                }
                .frame(alignment: .topLeading)
                VStack(alignment: .leading) {
                    HStack {
                        ratingsView
                        Spacer()
                        timeLabel
                    }
                    .padding([.horizontal, .top], 8)
                }
            }
            .cornerRadius(10)
        }
    }
    
    @ViewBuilder
    var title: some View {
        Text(store.recipeTitle)
            .font(FontStyle.headerTwo.font)
            .frame(height: 40, alignment: .top)
    }
    
    @ViewBuilder
    var imageView: some View {
        CacheImageView(imageUrlString: store.imageUrlString)
            .cornerRadius(10)
    }
    
    @ViewBuilder
    var ratingsView: some View {
        HStack(spacing: 2) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 12, height: 12)
            Text(store.ratingsString)
                .font(FontStyle.body.font)
        }
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 20).foregroundStyle(.yellow)
        )
    }
    
    @ViewBuilder
    var timeLabel: some View {
        Text(store.cookTimeString)
            .font(FontStyle.body.font)
            .padding(6)
            .background(
                RoundedRectangle(cornerRadius: 20).foregroundStyle(.white.opacity(0.4))
            )
    }
}

#Preview {
    RecipeCardView(store: Store(initialState: RecipeCardDomain.State(id: Recipe.sampleOne.id, recipe: Recipe.sampleOne)) {
        RecipeCardDomain()
    })
}
