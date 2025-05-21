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
    
    public var isActive: Bool /// Indicates whether the rating filter is active.
    public var value: Double /// Optional value of the rating (e.g., 4.5 stars).
    
    public init(isActive: Bool, value: Double = 0) {
        self.isActive = isActive
        self.value = value
    }
    
    public static func == (lhs: RatingModel, rhs: RatingModel) -> Bool {
        lhs.value == rhs.value
    }
}
