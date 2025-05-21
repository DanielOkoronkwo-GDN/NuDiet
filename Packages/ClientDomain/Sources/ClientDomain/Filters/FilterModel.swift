//
//  FilterModel.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation
import SwiftUI

/// Model encapsulating all filter options available in the app.
@Observable
public class FilterModel: Equatable {
    
    /// List of difficulty filter options (easy, medium, hard).
    public var difficultyLevels: [DifficultyModel] = [
        DifficultyModel(isSelected: false, difficulty: .easy),
        DifficultyModel(isSelected: false, difficulty: .medium),
        DifficultyModel(isSelected: false, difficulty: .hard)
    ]
    
    /// Rating filter option, allows filtering based on a rating value.
    public var rating: RatingModel = RatingModel(isActive: false)
    
    public static func == (lhs: FilterModel, rhs: FilterModel) -> Bool {
        lhs.difficultyLevels == rhs.difficultyLevels &&
        lhs.rating == rhs.rating
    }
}
