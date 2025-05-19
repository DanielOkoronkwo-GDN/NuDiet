//
//  CacheImageView.swift
//  NuDiet
//
//  Created by Daniel Okoronkwo on 18/05/2025.
//

import SwiftUI
import Kingfisher

struct CacheImageView: View {
 
    let imageUrlString: String
    
    var body: some View {
        KFImage.url(URL(string: imageUrlString)!)
            .fade(duration: 0.25)
            .onSuccess { result in
                // Register some analytic metric
            }
            .onFailure { error in
                // Either log or register some analytic metric
                // Attempt retry mechanism if necessary
            }
            .placeholder({
                progressView
            })
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    @ViewBuilder
    var progressView: some View {
        ProgressView()
            .tint(.accent.opacity(0.3))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

#Preview {
    CacheImageView(imageUrlString: "https://cdn.dummyjson.com/recipe-images/1.webp")
}

#Preview {
    CacheImageView(imageUrlString: "")

}
