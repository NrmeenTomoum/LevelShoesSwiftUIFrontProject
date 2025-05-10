//
//  ProductListViewModel.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 05/05/2025.
//
import Foundation
import Combine
import Observation

protocol WishListViewModelProtocol {
    func deleteProduct(for userId: String, productId: String) async throws -> Product
    func fetchWishListProducts(products:[Product],  userId: String) async throws -> [Product]
}

struct WishListViewModel: WishListViewModelProtocol {
    
    let repository: WishListRepositoryProtocol
    let appState: Store<AppState>
    
    init( repository: WishListRepositoryProtocol, appState: Store<AppState>) {
        self.repository = repository
        self.appState = appState
    }
    
    func fetchWishListProducts(products:[Product],  userId: String) async throws -> [Product] {
        
        do {
            let cancelBag = CancelBag()
            appState[\.userData.WishListProducts].setIsLoading(cancelBag: cancelBag)
            
            let response = try await repository.getWishListProducts(for: userId)
            appState[\.userData.WishListProducts] = .loaded(response.data)
            return response.data
            
        } catch {
            print("Failed to request products")
            throw WishListError.failedToFetchProducts
        }
    }
    
    func deleteProduct(for userId: String, productId: String) async throws -> Product {
        do {
            
            let response = try await repository.deleteWishListProduct(for: userId, productID: productId)
          //  appState[\.userData.WishListProducts] =
                //.value?.removeAll(where: { $0.id == response.data.id })
            
          //  appState[\.userData.WishListProducts].value?.removeFirst(where: { $0.id == response.data.id })
            return response.data
        } catch {
            throw WishListError.failedToDeleteProduct
        }
    }
    
}

enum WishListError: Error {
    case failedToFetchProducts
    case failedToDeleteProduct
}

extension WishListError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToFetchProducts:
            return "Failed to fetch products"
        case .failedToDeleteProduct:
            return "Failed to delete product"
        }
    }
}

struct StubWishListViewModel: WishListViewModelProtocol {
    func fetchWishListProducts(products: [Product], userId: String) async throws -> [Product] {
        throw ValueIsMissingError()
    }
    
    func deleteProduct(for userId: String, productId: String) async throws -> Product {
        throw ValueIsMissingError()
    }
}
