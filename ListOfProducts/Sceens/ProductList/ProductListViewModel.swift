//
//  ProductListViewModel.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 05/05/2025.
//
import Foundation
import Combine
import Observation

protocol ProductListViewModelProtocol {
    
    func fetchData(userId: String) async throws -> [Product]
    func onToggle(userId: String, productId: String, isFavorite: Bool) async throws -> Product
}

struct ProductListViewModel: ProductListViewModelProtocol {
    let wishListRepository: WishListRepositoryProtocol
    let  productRepository: ProductRepositoryProtocol
    let appState: Store<AppState>
    
    init( productRepository: ProductRepositoryProtocol, wishListRepository: WishListRepositoryProtocol, appState: Store<AppState>) {
        self.productRepository = productRepository
        self.wishListRepository = wishListRepository
        self.appState = appState
    }
    
    func fetchData( userId: String) async throws -> [Product] {
        do {
            // Fetch products and wishlist in parallel
            async let productsFetch = self.fetchProducts(userId: userId)
            async let wishlistFetch = self.fetchWishListProducts(userId: userId)
            var (products, wishlistProducts) = try await (productsFetch, wishlistFetch)
            for i in 0..<products.count {
                products[i].isFavorite = wishlistProducts.contains(products[i])
            }
            appState[\.userData.products] = .loaded(products)
            return products
        } catch {
            throw ProductError.failedToLoadData
        }
    }
    
    
    
    func fetchProducts(userId: String) async throws -> [Product] {
        do {
            let response = try await productRepository.getProducts()
            print(response.data.count)
            return response.data
        } catch {
            throw ProductError.failedToLoadData
        }
    }
    
    
    func fetchWishListProducts(userId: String) async throws -> [Product] {
        do {
            let response = try await wishListRepository.getWishListProducts(for: userId)
            print(response.data.count)
            return response.data
        } catch {
            throw ProductError.failedToLoadData
        }
    }
    
    func onToggle(userId: String, productId: String, isFavorite: Bool) async throws -> Product {
        if isFavorite {
            try await addProductToWishList(for: userId, productId: productId)
        }
        else {
            try await deleteProductFromWishList(for: userId, productId: productId)
        }
    }
    
    func deleteProductFromWishList(for userId: String, productId: String) async throws -> Product {
        do{
            let response = try await wishListRepository.deleteWishListProduct(for: userId, productID: productId)
            return response.data
        } catch {
            throw ProductError.faiiledToDelete
        }
    }
    func addProductToWishList(for userId: String, productId: String) async throws -> Product {
        do {
            let response = try await wishListRepository.addWishListProduct(for: userId, productID: productId)
            return response.data
        } catch {
            throw ProductError.failedToAdd
        }
    }
}

enum ProductError: Error {
    case injectionFailed
    case failedToLoadData
    case faiiledToDelete
    case failedToAdd
}

extension ProductError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .injectionFailed:
            return "Injection failed"
        case .failedToLoadData:
            return "Failed to load data"
        case .faiiledToDelete:
            return "failed To remove from wishlist "
        case .failedToAdd:
            return "failed To add to wishlist "
        }
    }
}


struct StubProductListViewModel: ProductListViewModelProtocol {
    func fetchData(userId: String) async throws -> [Product] {
        throw ValueIsMissingError()
    }
    
    func onToggle(userId: String, productId: String, isFavorite: Bool) async throws -> Product {
        throw ValueIsMissingError()
    }
}

struct ValueIsMissingError: Error {
    var localizedDescription: String {
        NSLocalizedString("Data of Injecton Values is missing ", comment: "")
    }
}
