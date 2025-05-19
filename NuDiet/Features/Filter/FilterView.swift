//
//  FilterView.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var model = FilterModel()
    
    var body: some View {
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
            .fontWeight(.medium)
        HStack {
            ForEach(model.difficultyLevels) { model in
                DifficultyFilterView(model: model)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    @ViewBuilder
    var ratingsContainer: some View {
        Text("Minimum rating: \(String(format: "%.2f", rating))")
            .fontWeight(.medium)
            .foregroundStyle(.gray)
        
        Slider(
            value: $rating,
            in: 1...5,
            step: 0.2
        ) {
            Text("Rating")
        } minimumValueLabel: {
            Text("0")
                .foregroundStyle(.gray)
        } maximumValueLabel: {
            Text("5")
                .foregroundStyle(.gray)
        }.tint(.blue.opacity(0.4))
    }
    
    @ViewBuilder
    var bottomContainer: some View {
        HStack {
            Button {
                
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
    
    @State private var rating: Double = 0
    @State private var isEditing = false
    
}

#Preview {
    FilterView()
}


extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
