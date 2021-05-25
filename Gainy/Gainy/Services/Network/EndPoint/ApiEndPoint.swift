import Foundation

/**
 Describes API endpoint.
 */
protocol ApiEndPoint {
    /// Base URL. Usually contains host.
    var baseURL: URL { get }

    /// Version of the API to use in the request.
    var apiVersion: String { get }

    /// URL path.
    var path: String { get }

    /// URL Request.
    var request: HttpRequest { get }

    /// HTTP method to use.
    var httpMethod: HttpMethod { get }

    /// Optional URL auth parameters to include in the request.
    var authUrlParameters: HttpParameters? { get }
}
