//
//  File.swift
//  ClientDomain
//
//  Created by Daniel Okoronkwo on 21/05/2025.
//

import Foundation
@testable import ClientDomain

extension PaginatedResponse: @unchecked Sendable {
    
    static let mock: PaginatedResponse = PaginatedResponse(
        recipes: [
            Recipe.sampleOne, Recipe.sampleTwo
        ],
        total: 2,
        skip: 0,
        limit: 10
    )
}
