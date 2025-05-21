//
//  DifficultyModel.swift
//  ClientDomain
//
//  Created by Daniel Okoronkwo on 21/05/2025.
//

import Foundation
import SwiftUICore

/// Enum representing difficulty levels for a recipe or task.
public enum difficultyLevel: String, CaseIterable {
    case easy, medium, hard
    
    /// Associated color for each difficulty level, used for UI representation.
    public var color: Color {
        switch self {
        case .easy: .green
        case .medium: .orange
        case .hard: .red
        }
    }
}

/// Model representing a single difficulty filter option.
@Observable
public class DifficultyModel: Identifiable, Hashable {

    public var isSelected: Bool = false /// Indicates whether this difficulty is currently selected in the filter.
    public var difficulty: difficultyLevel  /// The difficulty level associated with this model.
    
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
