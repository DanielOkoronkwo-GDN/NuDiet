//
//  DifficultyFilterView.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation
import SwiftUI
import ClientDomain

struct DifficultyFilterView: View {
    
    @Binding var model: DifficultyModel
    
    var body: some View {
        Button {
            model.isSelected.toggle()
        } label: {
            Text(model.difficulty.rawValue.capitalized)
                .padding(6)
                .frame(maxWidth: .infinity)
                .fontWeight(model.isSelected ? .bold : .medium)
        }
        .foregroundStyle(.white)
        .background(model.isSelected ? model.difficulty.color.opacity(0.7) : .brown.opacity(0.3))
        .clipShape(.capsule)
    }
}

#Preview {
    DifficultyFilterView(model: .constant(DifficultyModel(isSelected: false, difficulty: .easy)))
}
