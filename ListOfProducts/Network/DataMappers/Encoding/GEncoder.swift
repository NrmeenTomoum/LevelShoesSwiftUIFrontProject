import Foundation

public protocol GEncoder {
    func encode(value: Encodable) throws -> Data
}
