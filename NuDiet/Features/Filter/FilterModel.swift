//
//  FilterModel.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation
import SwiftUI

enum difficultyLevel: String, CaseIterable {
    case easy, medium, hard
    
    var color: Color {
        switch self {
        case .easy: .green
        case .medium: .orange
        case .hard: .red
        }
    }
}

@Observable
class DifficultyModel: Identifiable, Hashable {

    var isSelected: Bool = false
    var difficulty: difficultyLevel
    
    init(isSelected: Bool, difficulty: difficultyLevel) {
        self.isSelected = isSelected
        self.difficulty = difficulty
    }
    
    static func == (lhs: DifficultyModel, rhs: DifficultyModel) -> Bool {
        lhs.difficulty == rhs.difficulty && lhs.isSelected == rhs.isSelected
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(difficulty.rawValue)
        hasher.combine(isSelected)
    }
}

@Observable
class FilterModel: Equatable {
    
    var difficultyLevels: [DifficultyModel] = [
        DifficultyModel(isSelected: false, difficulty: .easy),
        DifficultyModel(isSelected: false, difficulty: .medium),
        DifficultyModel(isSelected: false, difficulty: .hard)
    ]
    
 
    var rating: RatingModel = RatingModel(isActive: false)
    
    static func == (lhs: FilterModel, rhs: FilterModel) -> Bool {
        lhs.difficultyLevels == rhs.difficultyLevels &&
        lhs.rating == rhs.rating
    }
}

@Observable
class RatingModel: Equatable {
    var isActive: Bool
    var value: Double?
    
    init(isActive: Bool, value: Double? = nil) {
        self.isActive = isActive
        self.value = value
    }
    
    static func == (lhs: RatingModel, rhs: RatingModel) -> Bool {
        lhs.value == rhs.value
    }
}
