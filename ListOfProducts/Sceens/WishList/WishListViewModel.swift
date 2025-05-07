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
    var isLoading: Bool {get}
    func deleteProduct(for userId: String, productId: String) async throws -> Product
    func fetchWishListProducts(products:[Product],  userId: String) async throws -> [Product]
}

@Observable
class WishListViewModel:BaseViewModel, WishListViewModelProtocol {
    
    var wishListproducts: [Product] = []
    var isLoading = false
    
    @ObservationIgnored let repository: WishListRepositoryProtocol
    
    init( repository: WishListRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchWishListProducts(products:[Product],  userId: String) async throws -> [Product] {

            do {
                let response = try await repository.getWishListProducts(for: userId)
                return response.data
            } catch {
                print("Failed to request products")
                throw WishListError.failedToFetchProducts
            }
    }
    
    func deleteProduct(for userId: String, productId: String) async throws -> Product {
                do {
                let response = try await repository.deleteWishListProduct(for: userId, productID: productId)
                self.wishListproducts.removeAll { $0.id == productId }
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
    
    var isLoading: Bool
    func deleteProduct(for userId: String, productId: String) async throws -> Product {
        throw ValueIsMissingError()
    }
}
