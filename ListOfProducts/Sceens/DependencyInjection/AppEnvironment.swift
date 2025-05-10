//
//  AppEnvironment.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 07/05/2025.
//

import Foundation

@MainActor
struct AppEnvironment {
    let diContainer: DIContainer
}

extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let appState = AppState()
        let session = configuredURLSession()
        let repositories = configuredWebRepositories(session: session)
        let viewModels = configuredViewModels(repositories: repositories, appState: appState)
        return AppEnvironment(diContainer: .init(appState: appState, viewModels: viewModels) )
    }
    
    private static func configuredURLSession() -> URLSessionProtocol {
        let configuration = URLSessionConfiguration.default
        //        configuration.timeoutIntervalForRequest = 60
        //        configuration.timeoutIntervalForResource = 120
        //        configuration.waitsForConnectivity = true
        //        configuration.httpMaximumConnectionsPerHost = 5
        //        configuration.requestCachePolicy = .returnCacheDataElseLoad
        //        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    
    private static func configuredWebRepositories(session: URLSessionProtocol) -> DIContainer.Repositories {
        let productRepository = ProductRepository(session: session)
        let wishListRepository = WishListRepository(session: session)
        return .init(wishListRepository: wishListRepository, productRepository: productRepository)
    }
    
    private static func configuredViewModels(
        repositories: DIContainer.Repositories, appState: AppState) -> DIContainer.ViewModels {
            let productListViewModel = ProductListViewModel(
                productRepository: repositories.productRepository, wishListRepository: repositories.wishListRepository, appState: appState)
            let wishListViewModel = WishListViewModel(repository: repositories.wishListRepository, appState: appState)
            return .init(productViewModel: productListViewModel, wishListViewModel: wishListViewModel)
        }
    
}

