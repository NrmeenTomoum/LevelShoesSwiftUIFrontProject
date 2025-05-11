//
//  ImagesPageView.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 03/05/2025.
//
import SwiftUI

struct EmptyView: View {
    var body: some View {
        Color.gray.opacity(0.1)
    }
}

struct ImagesPageView: View {
    let images: ImageModel
    
    var body: some View {
        AsyncImage(url: URL(string: images.url)) { phase in
            switch phase {
            case .empty:
                Color.gray.opacity(0.1)
                    .frame(height: 250)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Color.gray.opacity(0.1)
                    .frame(height: 250)
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    ImagesPageView(images: ImageModel("https://www.levelshoes.com/media/catalog/product/cache/d6b308721eea44dce854000e2ac7b2ba/8/1/815714aaec24928_1.jpg", height: 850, width: 607,gender: nil))
    
}
