//
//  ContentView.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import SwiftUI

struct RootView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "fork.knife")
                }
        }
    }
}

#Preview {
    RootView()
}
