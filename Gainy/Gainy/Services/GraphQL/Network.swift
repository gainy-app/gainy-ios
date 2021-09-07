import Apollo
import Foundation

public typealias float8 = Float
public typealias timestamptz = String

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

    let graphQLEndpointUrl = URL(string: "https://gainy-managed-dev.herokuapp.com/v1/graphql")!
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
