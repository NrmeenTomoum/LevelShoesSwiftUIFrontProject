//
//  Network.swift
//  App
//
//  Created by Nermeen Tomoum on 12/04/2025.
//

import Foundation
protocol NetworkProtocol {}

extension NetworkProtocol {
    
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        session: URLSessionProtocol = URLSession.shared,
        requestBuilder: RequestBuilding = RequestBuilder()
    ) async throws -> T {
        let request = try requestBuilder.build(from: endpoint)
        let (data, response) = try await session.data(for: request, delegate: nil)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError
        }
        
        return try AppResponse(
            data: data,
            statusCode: httpResponse.statusCode
        ).decode(as: T.self)
    }
    
}



