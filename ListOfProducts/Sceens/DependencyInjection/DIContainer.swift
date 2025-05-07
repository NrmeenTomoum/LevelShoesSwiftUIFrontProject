//
//  DIContainer.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 07/05/2025.
//

import SwiftUI

struct AppState: Equatable {
    var userData = UserData()
}

extension AppState {
    struct UserData: Equatable {
        var products: Loadable<[Product]> = .notRequested
        var WishListProducts: Loadable<[Product]> = .notRequested
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
