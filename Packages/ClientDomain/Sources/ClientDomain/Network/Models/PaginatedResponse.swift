//
//  PaginatedResponse.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation

public struct PaginatedResponse: Decodable, Equatable {
    var recipes: [Recipe]
    var total: Int
    var skip: Int
    var limit: Int
    
    var currentPage: Int {
        skip / limit + 1
    }
    
    var totalPages: Int {
        Int(ceil(Double(total) / Double(limit)))
    }
}
