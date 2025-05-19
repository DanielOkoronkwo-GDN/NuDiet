//
//  InfoItemView.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import SwiftUI

struct InfoItemView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            Text(subtitle)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    InfoItemView(title: "Easy", subtitle: "Difficulty")
}
