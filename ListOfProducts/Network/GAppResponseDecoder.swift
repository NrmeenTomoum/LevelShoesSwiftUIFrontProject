//
//  AppResponseDecoder.swift
//  App
//
//  Created by Nermeen Tomoum
//

import Foundation

// MARK: - AppResponseDecoder

public final class GAppResponseDecoder {
    public static let `default`: GAppResponseDecoder = .init(decoder: GJSONDecoder())
    private let decoder: JSONDecoder

    public init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    public func decode<T: Decodable>(
        _ response: AppResponse,
        as expectedType: T.Type
    ) throws
        -> T {
        try decodeAsNoContent(expectedType) ?? decodeAsExpectedType(response, as: expectedType)
    }

    private func decodeAsNoContent<T: Decodable>(_ expectedType: T.Type) -> T? {
        NoContentResponse() as? T
    }

    private func decodeAsExpectedType<T: Decodable>(_ response: AppResponse, as expectedType: T.Type) throws -> T {
        do {
            return try decoder.decode(expectedType, from: response.data)
        } catch {
            print(error)
            throw NetworkError.unmapableResponseError(response, error as? DecodingError)
        }
    }
}

public extension AppResponse {
    
    func decode<T: Decodable>(
        with decoder: GAppResponseDecoder = .default,
        as expectedType: T.Type
    ) throws
        -> T {
        if statusCode.isInSuccessRange {
            return try GAppResponseDecoder.default.decode(self, as: expectedType)
        } else if statusCode.isInServerFailuresRange {
            throw NetworkError.serverError
        } else {
            throw try GAppResponseDecoder.default.decode(self, as: ErrorResponse.self)
        }
    }
}

private extension Int {
    var isInSuccessRange: Bool {
        (200...399).contains(self)
    }

    var isInServerFailuresRange: Bool {
        (500...).contains(self)
    }
}

// MARK: - DecodableError

public protocol DecodableError: Error, Decodable { }

// MARK: - NoContentResponse

public class NoContentResponse: Decodable {
    public func erasingToVoid() {
        ()
    }
}
