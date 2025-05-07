//
//
//  Created by Nermeen Tomoum on 27/09/2022.
//

import Foundation

// MARK: - ErrorResponse

public struct ErrorResponse: Decodable {
    public var reason: String
    public var errorCode: ErrorCode?
    public var errors: [Message]?

    public enum ErrorCode: String, Decodable {
        case generic = "generic_error"
        case notFound = "not_found"
        case unknownType
    }

    enum CodingKeys: CodingKey {
        case reason
        case errorCode
        case errors
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reason = try container.decode(String.self, forKey: .reason)
        errorCode = try? container.decodeIfPresent(ErrorResponse.ErrorCode.self, forKey: .errorCode) ?? .unknownType
        errors = try container.decodeIfPresent([ErrorResponse.Message].self, forKey: .errors)
    }
}

// MARK: LocalizedError

extension ErrorResponse: LocalizedError {
    public var errorDescription: String? { reason }
}

public extension ErrorResponse {
    // MARK: - ErrorModel
    struct Message: Decodable {
        var message: String?
        var source: Source?
    }

    // MARK: - SourceModel

    struct Source: Decodable {
        var pointer: String?
        var parameter: String?
        var header: String?
    }
}
