//
//  PaginatedResponse.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 05/05/2025.
//
import Foundation
struct ApiResponse<T: Decodable>: Decodable {
    let data: T
    let statusCode: Int
    let message: String
    let pagination: Metadata?
    // MARK: - Metadata

    struct Metadata: Decodable {
        let total: Int
        let page: Int
        let perPage: Int

//        var nextPage: Int? {
//            isLastPage ? nil : count + 1
//        }

        var isLastPage: Bool {
            page == total
        }
    }
}
