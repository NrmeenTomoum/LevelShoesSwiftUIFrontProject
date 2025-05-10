//
//  WishListView.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 03/05/2025.
//

import SwiftUI

struct WishListView: View {
    @EnvironmentObject var user: User
    @Environment(\.dismiss) var dismiss
    @State private var wishListproducts: [Product] = []
    @State var wishListproductsState: Loadable<[Product]>
    @State var deleteproductsState: Loadable<Product>
    @Environment(\.injected) private var injected: DIContainer
    
    init(state: Loadable<[Product]> = .notRequested) {
        self._wishListproductsState = .init(initialValue: state)
        self._deleteproductsState = .init(initialValue: .notRequested)
    }
    var body: some View {
        content
    }
    
    @ViewBuilder private var content: some View {
        switch wishListproductsState {
        case .notRequested:
            defaultView()
        case .isLoading:
            loadingView()
        case let .loaded(wishListproducts):
            loadedView(wishListproducts: wishListproducts)
        case let .failed(error):
            failedView(error)
        }
    }
}

private extension WishListView {
    @ViewBuilder
    func loadedView(wishListproducts: [Product]) -> some View {
        List {
            ForEach(wishListproducts) { wishListproduct in
                WishListProduct(product: wishListproduct)
            }.onDelete { indexSet in
                if let index = indexSet.first {
                    deleteProduct(productId: wishListproducts[index].id)
                }
            }
            .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationBarBackButtonHidden()
        .navigationTitle(Text("Wishlist ( \(wishListproducts.count) )"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                })
                {
                    Image(systemName: "chevron.left")
                    
                }
            }
        }
        
    }
    
    func defaultView() -> some View {
        Text("No products in your wish list")
            .onAppear {
                if !wishListproducts.isEmpty {
                    wishListproductsState = .loaded(wishListproducts)
                }
                loadProductsList(forceReload: false)
            }
    }
    
    func loadingView() -> some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        }
    }
    
    func failedView(_ error: Error) -> some View {
        ErrorView(error: error, retryAction: {})
    }
}

private extension WishListView {
    private func loadProductsList(forceReload: Bool) {
        guard forceReload || wishListproducts.isEmpty else { return }
        $wishListproductsState.load {
            try await  injected.viewModels.wishListViewModel.fetchWishListProducts(products: wishListproducts,
                                                                                   userId: "68150b6a29021b5984886601")
        }
    }
    
    private func deleteProduct( productId: String) {
        $deleteproductsState.load {
            try await  injected.viewModels.wishListViewModel.deleteProduct(for: "68150b6a29021b5984886601",
                                                                           productId: productId)
        }
    }
}

#Preview {
    WishListView()
}
