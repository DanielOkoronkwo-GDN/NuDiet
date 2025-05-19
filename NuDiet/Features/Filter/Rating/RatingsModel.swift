//
//  RatingsModel.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation

@Observable
class RatingsModel: Identifiable, Hashable {

    var isSelected: Bool = false
    var value: Double
    
    init(isSelected: Bool, value: Double) {
        self.isSelected = isSelected
        self.value = value
    }
    
    static func == (lhs: RatingsModel, rhs: RatingsModel) -> Bool {
        lhs.value == rhs.value && lhs.isSelected == rhs.isSelected
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(isSelected)
    }
}
