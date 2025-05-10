//
//  ProductRepositoryProtocol.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 05/05/2025.
//
import Foundation

protocol ProductRepositoryProtocol: NetworkProtocol {
    func getProducts() async throws -> ApiResponse<[Product]>
}

struct ProductRepository: ProductRepositoryProtocol {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func getProducts() async throws -> ApiResponse<[Product]> {
        return try await request(ProductEndpoint.products, session: session)
    }
}
