import Apollo

class Network {
    static let shared = Network()

    // TODO: normal singletone?

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

    let graphQLEndpointUrl = URL(string: "https://gainy-dev.herokuapp.com/v1/graphql")!
}

class NetworkInterceptorProvider: LegacyInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(
        for operation: Operation
    ) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(), at: 0)
        return interceptors
    }
}

class CustomInterceptor: ApolloInterceptor {
    // MARK: Internal

    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Swift.Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        request.addHeader(name: "x-hasura-admin-secret", value: accessToken)

        print("request :\(request)")
        print("response :\(String(describing: response))")

        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }

    // MARK: Private

    private let accessToken = BundleReader().graphQLToken
}
