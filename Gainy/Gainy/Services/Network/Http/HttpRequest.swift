import Foundation

/**
 Represents HTTP request.
 */
struct HttpRequest {
    let bodyParameters: HttpParameters?
    let bodyEncoding: HttpParameterEncoding = .urlEncoding
    let urlParameters: HttpParameters?
}
