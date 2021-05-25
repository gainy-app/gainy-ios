/**
 The response’s HTTP status code.
 See RFC 2616 for details.
 */
enum HttpResponseStatusCode: Int {
    /// The request has succeeded.
    case ok = 200

    /// Unathorized access.
    case unauthorized = 401

    /// The requested URL is not found.
    case notFound = 404

    /// Too many requests were made (hit rate limit).
    case tooManyRequests = 429
}
