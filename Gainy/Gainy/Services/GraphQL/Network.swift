import Apollo
import Foundation
import FirebaseAuth
import Combine
import Accelerate

public typealias float8 = Float
public typealias timestamptz = String
public typealias timestamp = String
public typealias numeric = Double
public typealias smallint = Int
public typealias date = String
public typealias bigint = Int
public typealias _int4 = String
public typealias jsonb = String

private let iso8601DateFormatter = ISO8601DateFormatter()

//extension date: JSONDecodable, JSONEncodable {
//
//    public init(jsonValue value: JSONValue) throws {
//        guard let string = value as? String else {
//            throw JSONDecodingError.couldNotConvert(value: value, to: String.self)
//        }
//
//        guard let date = iso8601DateFormatter.date(from: string) else {
//            throw JSONDecodingError.couldNotConvert(value: value, to: Date.self)
//        }
//
//        self = date
//    }
//
//    public var jsonValue: JSONValue {
//        return iso8601DateFormatter.string(from: self)
//    }
//
//}

final class Network {
    static let shared = Network()

    // TODO: normal singletone - yes

    private(set) lazy var apollo: ApolloClient = {
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        
        let provider = NetworkInterceptorProvider(
            client: URLSessionClient(),
            store: store
        )

        return ApolloClient(
            networkTransport: RequestChainNetworkTransport(
                interceptorProvider: provider,
                endpointURL: URL(string: self.config.environment.baseURL)!
            ),
            store: store
        )
    }()
    private var config = Configuration()
    
    //MARK: - REST
    
    func makeAuthRequest(_ url: URL, completion: @escaping (Result<AuthorizationStatus, Error>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { data, response, error in

            if error != nil {
                completion(.success(.authorizingFailed))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      completion(.success(.authorizingFailed))
                      return
            }
            completion(.success(.authorizedFully))
        })
        task.resume()
    }
}

final class NetworkInterceptorProvider: DefaultInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(
        for operation: Operation
    ) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        let customInteractor = CustomInterceptor()
        customInteractor.subscribeOnFirebaseAuth()
        interceptors.insert(customInteractor, at: 0)
        return interceptors
    }
}

final class CustomInterceptor: ApolloInterceptor {
    
    
    @KeychainString("firebaseAuthToken")
    private(set) var firebaseAuthToken: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func subscribeOnFirebaseAuth() {
        
        NotificationCenter.default.publisher(for: Notification.Name.didReceiveFirebaseAuthToken).sink { _ in
        } receiveValue: { notification in
            if let token = notification.object as? String {
                self.firebaseAuthToken = token
            } else {
                self.firebaseAuthToken = nil
            }
        }.store(in: &cancellables)
    }
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Swift.Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        func makeRequest() {
            if Thread.isMainThread {
                DispatchQueue.global(qos: .background).async {
                    chain.proceedAsync(request: request,
                                       response: response,
                                       completion: completion)
                }
            } else {
                chain.proceedAsync(request: request,
                                   response: response,
                                   completion: completion)
            }
        }
        
        if let token = self.firebaseAuthToken {
            let bearer = "Bearer " + token
            request.addHeader(name: "Authorization", value: bearer)
            
            //TO-DO: Borysov compare Just dates stored after login
            let tokenValidator = FirebaseTokenValidator(token: token)
            if tokenValidator.isValidToken() {
                makeRequest()
            } else {
                let authManager = AuthorizationManager()
                authManager.getFirebaseAuthToken { success in
                    if success {
                        let bearer = "Bearer " + (authManager.firebaseAuthToken ?? token)
                        request.addHeader(name: "Authorization", value: bearer)
                        makeRequest()
                    } else {
                        NotificationCenter.default.post(name: NSNotification.Name.didFailToRefreshToken, object: nil)
                    }
                }
            }
            
        } else {
            makeRequest()
        }
        
        //dprint("request :\(request)")
        //dprint("response :\(String(describing: response))")
    }
}
