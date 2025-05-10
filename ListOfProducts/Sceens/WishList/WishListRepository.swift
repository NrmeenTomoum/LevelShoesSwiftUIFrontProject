//
//  WishListRepositoryProtocol.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 05/05/2025.
//
import Foundation

protocol WishListRepositoryProtocol : NetworkProtocol {
    func getWishListProducts(for userID: String) async throws -> ApiResponse<[Product]>
    func deleteWishListProduct(for userID: String, productID: String) async throws -> ApiResponse<Product>
    func addWishListProduct(for userID: String, productID: String) async throws -> ApiResponse<Product>
}

struct WishListRepository: WishListRepositoryProtocol {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    func getWishListProducts(for userID: String) async throws -> ApiResponse<[Product]> {
        return try await request(WishlistEndpoint.show(userID),session: session)
    }
    
    func deleteWishListProduct(for userID: String, productID: String) async throws -> ApiResponse<Product> {
        return try await request(WishlistEndpoint.delete(userID, productID),session: session)
    }
    
    func addWishListProduct(for userID: String, productID: String) async throws -> ApiResponse<Product> {
        return try await request(WishlistEndpoint.add(userID, productID),session: session)
    }
    
}

