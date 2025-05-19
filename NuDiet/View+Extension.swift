//
//  View+Extension.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
