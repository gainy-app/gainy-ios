import Apollo
import Foundation
import FirebaseAuth

public typealias float8 = Float
public typealias timestamptz = String
public typealias numeric = Double
public typealias smallint = Int

public typealias date = Foundation.Date

private let iso8601DateFormatter = ISO8601DateFormatter()

extension date: JSONDecodable, JSONEncodable {

    public init(jsonValue value: JSONValue) throws {
        guard let string = value as? String else {
            throw JSONDecodingError.couldNotConvert(value: value, to: String.self)
        }

        guard let date = iso8601DateFormatter.date(from: string) else {
            throw JSONDecodingError.couldNotConvert(value: value, to: Date.self)
        }

        self = date
    }

    public var jsonValue: JSONValue {
        return iso8601DateFormatter.string(from: self)
    }

}

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
                endpointURL: graphQLEndpointUrl
            ),
            store: store
        )
    }()

    let graphQLEndpointUrl = URL(string: "https://hasura-production.gainy-infra.net/v1/graphql")!
}

final class NetworkInterceptorProvider: DefaultInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(
        for operation: Operation
    ) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(), at: 0)
        return interceptors
    }
}

final class CustomInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Swift.Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        request.addHeader(name: "x-hasura-admin-secret", value: BundleReader().graphQLToken)

        print("request :\(request)")
        print("response :\(String(describing: response))")

        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}
