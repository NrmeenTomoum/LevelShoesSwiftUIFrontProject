//
//  DIContainer.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 07/05/2025.
//

import SwiftUI
import Combine

@Observable
class AppState{
    
    private(set) var products: [Product] = []
    private(set) var wishlist: [Product] = []
    
    private let store: UserData
    
    init(store: AppState.UserData = UserData()) {
        self.store = store
    }
    
    func refreshProducts() async {
        let products = await store.loadProducts()
        await MainActor.run {
            self.products = products
        }
    }
    
    func setproducts(_ products: [Product]) async {
        await store.setProducts(products)
        await refreshProducts()
    }
    
    func setWishlist(_ wishlist: [Product]) async {
        await store.setWishListProducts(wishlist)
        await refreshWishlistState()
    }
    
    
    func isInWishlist(_ product: Product)  -> Bool {
        return wishlist.contains(product)
    }
    
    func refreshWishlistState() async {
        let wishlist = await store.wishlist
        await MainActor.run {
            self.wishlist = wishlist
        }
    }
    
    func removeFromWishlist(product: Product) async {
        await store.removeFromWishlist(product)
        await refreshWishlistState()
    }
    
    func addToWishlist(product: Product) async {
        await store.addToWishlist(product)
        await refreshWishlistState()
    }
}

extension AppState {
    
    actor UserData {
        
        private(set) var products:[Product]  = []
        private(set)  var wishlist: [Product] = []
        
        var isInWishlist: (Product) -> Bool {
            return { product in
                self.wishlist.contains(where: { $0.id == product.id })
            }
        }
        
        func loadProducts() -> [Product] {
            return self.products
        }
        func getWishListProducts() -> [Product] {
            return self.wishlist
        }
        
        func setProducts(_ products: [Product]) {
            self.products = products
        }
        
        func appendproducts(_ products: [Product]) {
            self.products.append(contentsOf: products)
        }
        
        
        func setWishListProducts(_ products: [Product]) {
            self.wishlist = products
        }
        
        func appendWishListProducts(_ products: [Product]) {
            self.wishlist.append(contentsOf: products)
        }
        
        func removeFromWishlist(_ product: Product) {
            guard isInWishlist(product) else { return }
            self.wishlist.removeAll(where: { $0.id == product.id })
        }
        
        func addToWishlist(_ product: Product) {
            guard !isInWishlist(product) else { return }
            self.wishlist.append(product)
        }
        
    }
}

struct DIContainer {
    let appState: AppState
    let viewModels: ViewModels
}

extension DIContainer {
    struct Repositories {
        let wishListRepository: WishListRepositoryProtocol
        let  productRepository: ProductRepositoryProtocol
    }
    // for future use if i want to inject DB Services
    //    struct DBRepositories {
    //    }
    struct ViewModels {
        let productViewModel: ProductListViewModelProtocol
        let wishListViewModel: WishListViewModelProtocol
        
        static var stub: Self {
            .init(productViewModel: StubProductListViewModel(), wishListViewModel: StubWishListViewModel())
        }
    }
}

extension EnvironmentValues {
    @Entry var injected: DIContainer = DIContainer( appState:  AppState(), viewModels: .stub)
}

extension View {
    func inject(_ container: DIContainer) -> some View {
        return self
            .environment(\.injected, container)
    }
}
