import Foundation

typealias Parameters = [String: Any]

protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

enum HttpParameterEncoding {
    /// Encodes URL.
    case urlEncoding

    // MARK: Internal

    /**
     Encodes body and URL parameters to get URL components and include them into request.

     - parameter urlRequest: A URL load request that is independent of protocol or URL scheme.
     - parameter bodyParameters: HTTP body parameters.
     - parameter urlParameters: HTTP URL parameters.
     - parameter additionalParameters: Additional URL parameters.

     - throws: A `NetworkError` if the URL in the `urlRequest` in invalid.
     */
    func encode(urlRequest: inout URLRequest,
                bodyParameters _: Parameters?,
                urlParameters: Parameters?,
                additionalParameters: Parameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(
                    urlRequest: &urlRequest,
                    with: urlParameters.merging(
                        additionalParameters ?? [:],
                        uniquingKeysWith: { current, _ in current }
                    )
                )
            }
        } catch {
            throw error
        }
    }
}

struct URLParameterEncoder: ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else {
            throw NetworkError.invalidUrl
        }

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = [URLQueryItem]()

            for (key, value) in parameters {
                let queryItem = URLQueryItem(
                    name: key,
                    value: "\(value)"
                        .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                )
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8",
                                forHTTPHeaderField: "Content-Type")
        }
    }
}
