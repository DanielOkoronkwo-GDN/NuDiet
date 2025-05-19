//
//  APIClient.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation
import ComposableArchitecture
import DependenciesMacros

extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}

@DependencyClient
struct APIClient {
    var fetchPage: (_ page: Int, _ pageSize: Int) async throws -> PaginatedResponse
}

extension APIClient: TestDependencyKey {
    static let testValue = Self()
}

extension APIClient: DependencyKey {
    static let liveValue = APIClient(
           fetchPage: { page, pageSize in
               let skip = (page - 1) * pageSize
               let urlString = "https://dummyjson.com/recipes?limit=\(pageSize)&skip=\(skip)"
               guard let url = URL(string: urlString) else {
                   throw URLError(.badURL)
               }
               let (data, _) = try await URLSession.shared.data(from: url)
               return try JSONDecoder().decode(PaginatedResponse.self, from: data)
           }
       )
}
