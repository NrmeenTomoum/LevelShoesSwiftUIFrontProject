//
//  WishlistEndpoint.swift
//  Created by Nermeen Tomoum on 12/04/2025.
//
enum WishlistEndpoint {
    case show(String)
    case add(String,String)
    case delete(String,String)
}

extension WishlistEndpoint: Endpoint {
    
    var authenticationRequired: Bool {
        switch self {
        case .show, .add, .delete:
            false
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .show:
            return .GET
        case .add:
            return .POST
        case .delete:
            return .DELETE
        }
    }
    
    var task: EncodingTask {
        switch self {
        case .show, .add , .delete:
            return .plain
            
        }
    }
    
    var path: String {
        switch self {
        case .show(let userID):
            return "wishlist/\(userID)"
        case .add(let userID, let productID):
            return "wishlist/\(userID)/\(productID)"
        case .delete(let userID, let productID):
            return "wishlist/\(userID)/\(productID)"
        }
    }
}
