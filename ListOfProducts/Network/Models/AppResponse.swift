//
//  Response.swift
//  App
//
//  Created by Nermeen Tomoum on 12/04/2025.
//

import Foundation

// MARK: - Response

public struct AppResponse {
    public let data: Data
    public let statusCode: Int
    public let metadata: Metadata?
    
    public init(
        data: Data,
        statusCode: Int,
        metadata: Metadata? = nil
    ) {
        self.data = data
        self.statusCode = statusCode
        self.metadata = metadata
    }
}

// MARK: Response.Metadata

public extension AppResponse {
    /// Useful other data to help in debugging
    struct Metadata {
        public let request: URLRequest?
        public let response: HTTPURLResponse?
        public let task: URLSessionTask?
        
        public init(
            request: URLRequest?,
            response: HTTPURLResponse?,
            task: URLSessionTask?
        ) {
            self.request = request
            self.response = response
            self.task = task
        }
    }
}

private extension String {
    static let noneFound = "🤷‍♂️ None Found"
}
