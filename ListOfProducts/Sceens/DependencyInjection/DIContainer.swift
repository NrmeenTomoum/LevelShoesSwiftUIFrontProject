//
//  DIContainer.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 07/05/2025.
//

import SwiftUI

struct DIContainer {
    
    // let appState: Store<AppState>
    let viewModels: ViewModels
    // appState: AppState,
    init( viewModels: ViewModels) {
        //        self.appState = appState
        self.viewModels = viewModels
    }
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
            .init(productViewModel: StubProductListViewModel(), wishListViewModel: StubWishListViewModel(isLoading: false))
        }
    }
}

extension EnvironmentValues {
    @Entry var injected: DIContainer = DIContainer( viewModels: .stub)
}

extension View {
    func inject(_ container: DIContainer) -> some View {
        return self
            .environment(\.injected, container)
    }
}
