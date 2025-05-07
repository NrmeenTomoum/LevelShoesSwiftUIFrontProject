//
// GJSONDecoder.swift
//  App
//
//  Created by Nermeen Tomoum on 12/04/2025.
//

import Foundation

// MARK: - JSONDecoder

public final class GJSONDecoder: JSONDecoder {
    public init(_ decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) {
        super.init()
            //keyDecodingStrategy = decodingStrategy
        dateDecodingStrategy = .iso8601
    }

    override public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        do {
            return try super.decode(type, from: data)
        } catch let error as DecodingError {
            throw error
        } catch {
            throw error
        }
    }
}

public extension Data {
    func decodeOrNil<T: Decodable>(_ type: T.Type) -> T? {
        try? GJSONDecoder().decode(type, from: self)
    }

    func decode<T: Decodable>(_ type: T.Type) throws -> T {
        try GJSONDecoder().decode(type, from: self)
    }
}
