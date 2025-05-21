//
//  FilterModel.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation
import SwiftUI

public enum difficultyLevel: String, CaseIterable {
    case easy, medium, hard
    
    public var color: Color {
        switch self {
        case .easy: .green
        case .medium: .orange
        case .hard: .red
        }
    }
}

@Observable
public class DifficultyModel: Identifiable, Hashable {

    public var isSelected: Bool = false
    public var difficulty: difficultyLevel
    
    public init(isSelected: Bool, difficulty: difficultyLevel) {
        self.isSelected = isSelected
        self.difficulty = difficulty
    }
    
    public static func == (lhs: DifficultyModel, rhs: DifficultyModel) -> Bool {
        lhs.difficulty == rhs.difficulty && lhs.isSelected == rhs.isSelected
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(difficulty.rawValue)
        hasher.combine(isSelected)
    }
}

@Observable
public class FilterModel: Equatable {
    
    public var difficultyLevels: [DifficultyModel] = [
        DifficultyModel(isSelected: false, difficulty: .easy),
        DifficultyModel(isSelected: false, difficulty: .medium),
        DifficultyModel(isSelected: false, difficulty: .hard)
    ]
    
    public var rating: RatingModel = RatingModel(isActive: false)
    
    public static func == (lhs: FilterModel, rhs: FilterModel) -> Bool {
        lhs.difficultyLevels == rhs.difficultyLevels &&
        lhs.rating == rhs.rating
    }
}

@Observable
public class RatingModel: Equatable {
    var isActive: Bool
    var value: Double?
    
    init(isActive: Bool, value: Double? = nil) {
        self.isActive = isActive
        self.value = value
    }
    
    public static func == (lhs: RatingModel, rhs: RatingModel) -> Bool {
        lhs.value == rhs.value
    }
}
