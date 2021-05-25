import Foundation

/**
 Object that manages network requests to an API end point.
 */
class NetworkRouter<EndPoint: ApiEndPoint>: ApiRouter {
    // MARK: Internal

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            print("URL \(String(describing: request.url))")

            task = session.dataTask(with: request) { data, response, error in
                completion(data, response, error)
            }
        } catch {
            completion(nil, nil, error)
        }

        self.task?.resume()
    }

    // MARK: Private

    // MARK: Private properties

    private var task: URLSessionTask?
    private let requestTimeout = 5.0

    // MARK: Private functions

    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        let requestUrl = route
            .baseURL
            .appendingPathComponent(route.apiVersion)
            .appendingPathComponent(route.path)

        var request = URLRequest(url: requestUrl,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: requestTimeout)

        request.httpMethod = route.httpMethod.rawValue
        do {
            try self.configureParameters(bodyParameters: route.request.bodyParameters,
                                         bodyEncoding: route.request.bodyEncoding,
                                         urlParameters: route.request.urlParameters,
                                         authUrlParameters: route.authUrlParameters,
                                         request: &request)

            return request
        } catch {
            throw error
        }
    }

    private func configureParameters(bodyParameters: HttpParameters?,
                                     bodyEncoding: HttpParameterEncoding,
                                     urlParameters: HttpParameters?,
                                     authUrlParameters: HttpParameters?,
                                     request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(
                urlRequest: &request,
                bodyParameters: bodyParameters,
                urlParameters: urlParameters,
                additionalParameters: authUrlParameters
            )
        } catch {
            throw error
        }
    }
}
