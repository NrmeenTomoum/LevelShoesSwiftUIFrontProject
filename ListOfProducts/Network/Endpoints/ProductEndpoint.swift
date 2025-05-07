//
//  ProductEndpoint.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 05/05/2025.
//

import Foundation

enum ProductEndpoint {
    case products
}

extension ProductEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .products:
            return "products"
        }
    }
    
    var authenticationRequired: Bool {
        switch self {
        case .products:
            false
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .products:
            return .GET
        }
    }
    
    var task: EncodingTask {
        switch self {
        case .products:
            return .plain
        }
    }
}
