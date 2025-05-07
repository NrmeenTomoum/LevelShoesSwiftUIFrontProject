//
//  JSONEncoder.swift
//  
//
//  Created by Nermeen Tomoum on 12/04/2025.
//

import Foundation

// MARK: - JSONEncoder

public final class GJSONEncoder: JSONEncoder, GEncoder {
    override public init() {
        super.init()
        keyEncodingStrategy = .convertToSnakeCase
        dateEncodingStrategy = .iso8601
    }

    public func encode(value: Encodable) throws -> Data {
        try super.encode(value)
    }
}

public extension Encodable {
    func asDictionary(_ encoder: GEncoder = GJSONEncoder()) -> [String: Any] {
        let serialized = (try? JSONSerialization.jsonObject(with: encode(with: encoder), options: .allowFragments)) ?? nil
        return serialized as? [String: Any] ?? [String: Any]()
    }

    func encode(with encoder: GEncoder = GJSONEncoder()) throws -> Data {
        do {
            return try encoder.encode(value: self)
        } catch EncodingError.invalidValue(let value, let context) {
            throw EncodingError.invalidValue(value, context)
        } catch {
            throw error
        }
    }
}

public extension Dictionary {
    func encode() throws -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self)
        } catch {
            throw error
        }
    }
}
