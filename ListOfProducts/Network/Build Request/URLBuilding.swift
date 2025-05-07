//
//  URLBuilding.swift
//  Created by Nermeen Tomoum on 12/04/2025.
//
import Foundation

protocol URLBuilding {
    func buildURL(from endpoint: Endpoint) throws -> URL
}

struct DefaultURLBuilder: URLBuilding {
    func buildURL(from endpoint: Endpoint) throws -> URL {
     
        guard var urlComponents = URLComponents(string: endpoint.fullURL) else {
            throw NetworkError.invalidURL
        }

        if case let .url(parameters, encoder) = endpoint.task {
            urlComponents.queryItems = parameters
                .asDictionary(encoder)
                .map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        return url
    }
}
