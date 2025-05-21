//
//  APIClient.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import ComposableArchitecture
import DependenciesMacros
import Foundation

/// A dependency client responsible for fetching paginated recipe data from an API.
@DependencyClient
struct APIClient: @unchecked Sendable {
    
    /// A function to fetch a page of recipe data.
    ///
    /// - Parameters:
    ///   - page: The page number to fetch (starting from 1).
    ///   - pageSize: The number of items per page.
    /// - Returns: A `PaginatedResponse` containing the fetched recipes.
    var fetchPage: (_ page: Int, _ pageSize: Int) async throws -> PaginatedResponse
}

// MARK: - Live Implementation
extension APIClient: DependencyKey {
    /// The live value of `APIClient` used in production, fetching from the dummyjson.com API.
    static let liveValue = APIClient(
        fetchPage: { page, pageSize in
            let skip = (page - 1) * pageSize
            let urlString = "https://dummyjson.com/recipes?limit=\(pageSize)&skip=\(skip)"
            
            // Ensure the URL is valid
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }
            
            // Fetch and decode the data from the URL
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(PaginatedResponse.self, from: data)
        }
    )
}

// MARK: - Dependency Injection Integration
extension DependencyValues {
    
    /// Accessor for the `APIClient` within the dependency system.
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}
