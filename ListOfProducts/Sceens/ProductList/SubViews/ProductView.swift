//
//  ContentView.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 03/05/2025.
//

import SwiftUI

struct ProductView: View {
    @Environment(\.injected) private var injected: DIContainer
    let product: Product
    let onToggle: () -> Void
    
    // MARK: - Constants
    private let imageSize: CGFloat = 20
    private let padding: CGFloat = 8
    
    var body: some View {
        VStack(alignment: .leading, spacing: padding) {
            productImage
            productDetails
            Spacer()
        }
    }
    
    // MARK: - View Components
    private var productImage: some View {
        ImagesPageView(images: product.image)
            .overlay(alignment: .top) {
                HStack {
                    Spacer()
                    favoriteButton
                }
            }
    }
    
    private var favoriteButton: some View {
        Button(action: onToggle) {
            Image(systemName: injected.appState.isInWishlist(product) ? "heart.fill" : "heart")
                .resizable()
                .foregroundColor(.black)
                .frame(width: imageSize, height: imageSize)
                .padding()
        }
    }
    
    private var productDetails: some View {
        Group {
            Text(product.brandName.uppercased())
                .font(.caption)
                .fontWeight(.bold)
                .lineLimit(1)
            
            Text(product.name)
                .font(.caption)
                .lineLimit(1)
            
            Text(product.originalPrice)
                .font(.caption)
                .fontWeight(.medium)
            
            BadgeView(bagde: product.badges)
        }
        .padding(.leading)
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var product: Product = Product(
        id: "",
        name: "Wander matelassé small hobo bag",
        originalPrice: "10,500 AED",
        salePrice: "5,565 AED",
        image: ImageModel(
            "https://www.levelshoes.com/media/catalog/product/cache/d6b308721eea44dce854000e2ac7b2ba/8/1/815714aaec24928_1.jpg",
            height: 850,
            width: 607
        ),
        isFavorite: true,
        brandName: "Miu Miu",
        badges: [.init(text: .new), .init(text: .preLaunch)]
    )
    
    return ProductView(
        product: product,
        onToggle: {}
    )
}

