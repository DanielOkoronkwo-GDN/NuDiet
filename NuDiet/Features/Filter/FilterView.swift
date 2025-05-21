//
//  FilterView.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import SwiftUI
import ComposableArchitecture
import ClientDomain

struct FilterView: View {
        
    @State private var isEditing = false
    
    @State private var rating: Double = 0.0
    @State private var filter: FilterModel = .init()
    
    @Environment(\.dismiss) var dismiss
    
    private let store: StoreOf<RecipeListDomain>
    
    public init(store: StoreOf<RecipeListDomain>) {
        self.store = store
    }
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack {
                components
                .toolbar {
                    cancelButton
                }
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        bottomContainer
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle")
                .tint(Color.gray.opacity(0.6))
        }
    }
    
    @ViewBuilder
    var components: some View {
        VStack(alignment: .leading, spacing: 20) {
            difficultyContainer
            ratingsContainer
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .navigationTitle("FILTERS")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    var difficultyContainer: some View {
        Text("Difficulty")
            .foregroundStyle(.gray)
            .fontWeight(filter.difficultyLevels.filter({ $0.isSelected }).isEmpty == false ? .bold : .medium)
        HStack {
            ForEach($filter.difficultyLevels) { model in
                DifficultyFilterView(model: model)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    @ViewBuilder
    var ratingsContainer: some View {
        Text("Minimum rating: \(String(format: "%.2f", filter.rating.value))")
            .fontWeight(filter.rating.isActive ? .bold : .medium)
            .foregroundStyle(.gray)
        
        Slider(
            value: $filter.rating.value,
            in: 1...5,
            step: 0.2
        ) {
            Text("Rating")
        } minimumValueLabel: {
            Text("0")
                .foregroundStyle(.gray)
                .fontWeight(filter.rating.isActive ? .bold : .medium)
        } maximumValueLabel: {
            Text("5")
                .foregroundStyle(.gray)
                .fontWeight(filter.rating.isActive ? .bold : .medium)
        }
        .onChange(of: filter.rating.value) { _, newValue in
            filter.rating.isActive = true
        }
        .tint(.blue.opacity(0.4))
    }
    
    private func triggerClearOperation() {
        filter.difficultyLevels.forEach({ $0.isSelected = false })
        store.send(.clearFilter)
        dismiss()
    }
    
    @ViewBuilder
    var bottomContainer: some View {
        HStack {
            Button {
                triggerClearOperation()
            } label: {
                Text("Clear")
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, minHeight: 44)
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(
                    cornerRadius: 5,
                    style: .continuous
                )
                .fill(Color.gray.opacity(0.3))
            )

            Button {
                store.send(.applyFilter(filter: filter))
            } label: {
                Text("Apply")
                    .fontWeight(.bold)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 44)
            .background(
                RoundedRectangle(
                    cornerRadius: 5,
                    style: .continuous
                )
                .fill(Color.green.opacity(0.8))
            )
        }
    }
}

#Preview {
    FilterView(store: Store(
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
