//
//  RatingModel.swift
//  ClientDomain
//
//  Created by Daniel Okoronkwo on 21/05/2025.
//

import Foundation

/// Model representing a rating filter.
@Observable
public class RatingModel: Equatable {
    
    var isActive: Bool /// Indicates whether the rating filter is active.
    var value: Double? /// Optional value of the rating (e.g., 4.5 stars).
    
    init(isActive: Bool, value: Double? = nil) {
        self.isActive = isActive
        self.value = value
    }
    
    public static func == (lhs: RatingModel, rhs: RatingModel) -> Bool {
        lhs.value == rhs.value
    }
}
