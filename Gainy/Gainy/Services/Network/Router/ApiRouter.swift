import Foundation

typealias NetworkRouterCompletion =
    (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

/**
 Describes API router that is capable to make requests to the API endpoints.
 */
protocol ApiRouter: AnyObject {
    associatedtype EndPoint: ApiEndPoint

    /**
     Makes a request to the API endpoint.

     - parameter route: Route to the endpoint to make a request.
     - parameter completion: Completion handler that is called upon successful request or if error occured.
     */
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
}
