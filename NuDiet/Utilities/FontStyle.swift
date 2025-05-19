//
//  FontStyle.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import Foundation
import SwiftUI

enum FontStyle {
    case title
    case headerOne
    case headerTwo
    case body
    case regular
    case caption
    
    var font: Font {
        switch self {
        case .title:
            return Font.system(size: 36, weight: .medium, design: .rounded)
        case .headerOne:
            return Font.system(size: 20, weight: .medium, design: .rounded)
        case .headerTwo:
            return Font.system(size: 16, weight: .medium)
        case .body:
            return Font.system(size: 12, weight: .bold)
        case .caption:
            return Font.system(size: 12, weight: .light)
        case .regular:
            return Font.system(size: 12)
        }
    }
}
