//
//  ProductRepositoryProtocol.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 05/05/2025.
//
import Foundation

protocol ProductRepositoryProtocol: NetworkProtocol {
    func getProducts(page: Int) async throws -> ApiResponse<[Product]>
}

struct ProductRepository: ProductRepositoryProtocol {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func getProducts(page: Int = 1) async throws -> ApiResponse<[Product]> {
        return try await request(ProductEndpoint.products(page, 8)
                                 ,session: session)
    }
}
