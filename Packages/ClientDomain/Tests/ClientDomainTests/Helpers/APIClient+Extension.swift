//
//  File.swift
//  ClientDomain
//
//  Created by Daniel Okoronkwo on 21/05/2025.
//

import Foundation
import ComposableArchitecture

@testable import ClientDomain

extension APIClient: TestDependencyKey {
    
    static let testValue = APIClient(
        fetchPage: { page, pageSize in
            return .mock
        }
    )
}
