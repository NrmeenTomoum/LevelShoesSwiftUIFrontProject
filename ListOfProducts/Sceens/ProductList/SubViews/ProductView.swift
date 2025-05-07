//
//  ContentView.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 03/05/2025.
//

import SwiftUI

struct ProductView: View {
    var product: Product
    @State var isFavorite: Bool = false
    let onToggle: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            ImagesPageView(images: product.image)
                .overlay(alignment: .top) {
                    HStack {
                        Spacer()
                        Button(action: {
                            isFavorite.toggle()
                            onToggle()
                        }) {
                            Image(systemName: isFavorite ? "heart.fill": "heart")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 20, height: 20)
                                .padding()
                        }
                    }
                }
            Group{
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
            }.padding(.leading)
            Spacer()
        }
    }
    
}

#Preview {
    @Previewable @State  var product: Product = Product(id: "", name: "Wander matelassé small hobo bag", originalPrice: "10,500 AED", salePrice: "5,565 AED", image: ImageModel("https://www.levelshoes.com/media/catalog/product/cache/d6b308721eea44dce854000e2ac7b2ba/8/1/815714aaec24928_1.jpg", height: 850, width: 607), isFavorite: true, brandName: "Miu Miu", badges: [.init(text: .new),.init(text: .preLaunch)])
    ProductView(product: product,
                onToggle: {})
}

