//
//  WishListProduct.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 03/05/2025.
//

import SwiftUI

struct WishListProduct: View {
    let product: Product
    var body: some View {
        HStack(alignment: .top, spacing: 8){
            ImagesPageView(images: product.image )
                .frame(width: 200)
            VStack(alignment: .leading){
                Text(product.brandName.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                
                Text(product.name)
                    .font(.caption)
                    .lineLimit(1)
                
                Text(product.originalPrice)
                    .font(.caption)
                    .fontWeight(.medium)
                
                BadgeView(bagde: product.badges)
            }
            Spacer()
        }
    }
}

#Preview {
    WishListProduct(product: Product(id: "", name: "Wander matelassé small hobo bag", originalPrice: "10,500 AED", salePrice: "5,565 AED", image: ImageModel("https://www.levelshoes.com/media/catalog/product/cache/d6b308721eea44dce854000e2ac7b2ba/8/1/815714aaec24928_1.jpg", height: 850, width: 607,gender: nil), isFavorite: true, brandName: "Miu Miu", badges: [.init(text:.new),.init(text:.preLaunch)], discountPercentage: nil))
}


