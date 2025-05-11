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
    func fetchProducts(userId: String, pageNumber: Int) async throws -> [Product]
    func fetchData(userId: String) async throws -> [Product]
    func onToggle(userId: String, productId: String, isFavorite: Bool) async throws -> Product
}

struct ProductListViewModel: ProductListViewModelProtocol {
    let wishListRepository: WishListRepositoryProtocol
    let  productRepository: ProductRepositoryProtocol
    let appState: AppState
    
    init( productRepository: ProductRepositoryProtocol, wishListRepository: WishListRepositoryProtocol,
          appState: AppState) {
        self.productRepository = productRepository
        self.wishListRepository = wishListRepository
        self.appState = appState
    }
    
    func fetchData( userId: String) async throws -> [Product] {
        do {
            async let productsFetch = self.fetchProducts(userId: userId)
            async let wishlistFetch = self.fetchWishListProducts(userId: userId)
            var (products, wishlistProducts) = try await (productsFetch, wishlistFetch)
            
            for i in 0..<products.count {
                products[i].isFavorite = wishlistProducts.contains(products[i])
            }

            return products
        } catch {
            throw ProductError.failedToLoadData
        }
    }
    
    func fetchProducts(userId: String, pageNumber: Int = 1) async throws -> [Product] {
        do {
            let response = try await productRepository.getProducts(page: pageNumber)
            if pageNumber == 1 {
                await  appState.setProducts(response.data)

            } else {
                await appState.appendToProducts(response.data)
            }
            return response.data
        } catch {
            throw ProductError.failedToLoadData
        }
    }
    
    func fetchWishListProducts(userId: String) async throws -> [Product] {
        do {
            let response = try await wishListRepository.getWishListProducts(for: userId)
            await  appState.setWishlist(response.data)
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
            let response = try await wishListRepository.deleteWishListProduct(for: userId,
                                                                              productID: productId)
            await  appState.removeFromWishlist(product: response.data)
            return response.data
        } catch {
            throw ProductError.faiiledToDelete
        }
    }
    
    func addProductToWishList(for userId: String, productId: String) async throws -> Product {
        do {
            let response = try await wishListRepository.addWishListProduct(for: userId,
                                                                           productID: productId)
            await appState.addToWishlist(product: response.data)
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
    func fetchProducts(userId: String, pageNumber: Int) async throws -> [Product]{
        throw ValueIsMissingError()
    }
    
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
