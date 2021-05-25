import Foundation

/**
 Represents error occured while doing network request.
 */
enum NetworkError: Error {
    /// The URL in invalid.
    case invalidUrl
}

extension NetworkError: LocalizedError {}
