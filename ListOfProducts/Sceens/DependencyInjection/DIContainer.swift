//
//  DIContainer.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 07/05/2025.
//

import SwiftUI

actor AppState {
    var userData = UserData()
}

extension AppState {
    
    actor UserData {
        
        var products: Loadable<[Product]> = .notRequested
        private(set)  var WishListProducts: Loadable<[Product]> = .notRequested
        
        var isInWishlist: (Product) -> Bool {
             return { product in
                self.WishListProducts.value?.contains(where: { $0.id == product.id }) ?? false
            }
         }
        
        func removeFromWishList(_ product: Product) {
            guard isInWishlist(product) else { return }
            var updatedWishListProducts = self.WishListProducts.value ?? []
            updatedWishListProducts.removeAll(where: { $0.id == product.id })
            self.WishListProducts = .loaded(updatedWishListProducts)
        }
        
        func addToWishList(_ product: Product) {
            guard !isInWishlist(product) else { return }
            var updatedWishListProducts = self.WishListProducts.value ?? []
            updatedWishListProducts.append(product)
            self.WishListProducts = .loaded(updatedWishListProducts)
        }
        
    }
}

struct DIContainer {
    let appState: Store<AppState>
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
    @Entry var injected: DIContainer = DIContainer( appState: .init(AppState()), viewModels: .stub)
}

extension View {
    func inject(_ container: DIContainer) -> some View {
        return self
            .environment(\.injected, container)
    }
}
