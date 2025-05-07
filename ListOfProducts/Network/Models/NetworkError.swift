//
//  NetworkError.swift
//  App
//
//  Created by Nermeen Tomoum on 12/04/2025.
//
// MARK: - NetworkError

public enum NetworkError: Error {
    case canceledError, unauthorizedError, unreachableError, excessiveRefresh, missingCredentials
    case unmapableResponseError(AppResponse, DecodingError?)
    case unknownNetworkError(Error?)
    case retryFailureNetworkError(Error?, Error?)
    case responseValidationNetworkError(Reason)
    case serverError
    case invalidURL
    case unkown(Error?)
}

// MARK: Loggable

public extension NetworkError {
    var errorDescription: String? {
        switch self {
        case .serverError:
            return "Server Failure has been encountered"
        case .canceledError:
            return "Request has been cancelled"
        case .unauthorizedError:
            return "Unauthorized error occured"
        case .unreachableError:
            return "Network is Unreachable"
        case .excessiveRefresh:
            return """
                Failed to authenticate due to many token refresh retries
                """
        case .missingCredentials:
            return """
                Failed to authenticate due to missing credentials
                """
        case .unmapableResponseError(let response, let decodingError):
            return """
                Decoding Error occured

                ---
                Error:
                \(decodingError.debugDescription)

                ---
                Response:
                \(response)
                """
        case .unknownNetworkError(let underlyingError):
            if let underlyingError {
                return """
                    Unknown Network Error Occured
                    Error Description: \(underlyingError.localizedDescription)

                    ---

                    Error Object: \(underlyingError)
                    """
            } else {
                return "Unknown Network Error Occured"
            }

        case .retryFailureNetworkError(let retryError, let originalError):
            return """
                Failed to retry Network Request

                ---
                Retry Error: \(retryError.debugDescription)

                ---
                Original Error: \(originalError.debugDescription)
                """
        default:
            return """
                Network Failure Error Occured

                \(localizedDescription)

                ---

                \(self)
                """
        }
    }

    enum Reason {
        /// The response did not contain a `Content-Type` and the `acceptableContentTypes` provided did not contain a
        /// wildcard type.
        case missingContentType(acceptableContentTypes: [String])
        /// The response `Content-Type` did not match any type in the provided `acceptableContentTypes`.
        case unacceptableContentType(acceptableContentTypes: [String], responseContentType: String)

        case unknown
    }
}
