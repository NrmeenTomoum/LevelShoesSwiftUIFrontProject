//
//  Endpoint.swift
//  Created by Nermeen Tomoum on 12/04/2025.
//
public typealias HTTPHeaders = [String: String]
public typealias HTTPParameters = [String: Any]

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

public enum EncodingTask {
    case plain
    case body(Encodable, GEncoder = GJSONEncoder())
    case url(Encodable, GEncoder = GJSONEncoder())
}



protocol Endpoint {
    var id: String { get }
    var baseURL: String { get }
    var path: String { get }
    //    var version: String { get }
    var fullURL: String { get }
    // var headers: HTTPHeaders { get }
    var task: EncodingTask { get }
    var method: HTTPMethod { get }
    var authenticationRequired: Bool { get }
}


extension Endpoint {
    var id: String {
        "/\(path):\(method.rawValue.uppercased())"
    }
    
    /// Base URL for calling endpoints which is configurable according to Build
    /// Configurations
    var baseURL: String {
        Constant.baseURL
    }
    
    var headers: HTTPHeaders {
        defaultHeaders()
    }
    
    var fullURL: String {
        defaultFullURL()
    }
    
}

extension Endpoint {
    
    func defaultHeaders() -> HTTPHeaders {
        var headers = ["":""]
        
        switch method {
        case .POST,
                .PUT,
                .PATCH:
            headers["Content-Type"] = "application/json"
        default:
            break
        }
        
        return headers
    }
    
    func defaultFullURL() -> String {
        baseURL + path
    }
}

