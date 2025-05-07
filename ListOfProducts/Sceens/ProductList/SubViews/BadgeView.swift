//
//  BadgeView.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 03/05/2025.
//
import SwiftUI

struct BadgeView: View {
    let bagde: [Badge]
    var body: some View {
        HStack {
            ForEach(bagde) { badge in
                Text(badge.text.rawValue)
                    .font(.system(size: 10))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(4)
            }
            
        }
    }
}
#Preview{
    BadgeView(bagde: [.init(text: .new),.init(text: .preLaunch)])
}
