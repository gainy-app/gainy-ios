//
//  GainyNetworkProtocol.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 15.09.2022.
//

import Apollo
import Dispatch

public protocol GainyNetworkProtocol: AnyObject {
    @discardableResult func fetch<Query: GraphQLQuery>(query: Query,
                                                              cachePolicy: CachePolicy,
                                                              contextIdentifier: UUID?,
                                                              queue: DispatchQueue,
                                                              resultHandler: GraphQLResultHandler<Query.Data>?) -> Cancellable
    
    @discardableResult
    func perform<Mutation: GraphQLMutation>(mutation: Mutation,
                                                   publishResultToStore: Bool,
                                                   queue: DispatchQueue,
                                                   resultHandler: GraphQLResultHandler<Mutation.Data>?) -> Cancellable
}

extension GainyNetworkProtocol {
    @discardableResult public func fetch<Query: GraphQLQuery>(query: Query,
                                                              cachePolicy: CachePolicy = .default,
                                                              contextIdentifier: UUID? = nil,
                                                              queue: DispatchQueue = .main,
                                                              resultHandler: GraphQLResultHandler<Query.Data>? = nil) -> Cancellable
    {
        fetch(query: query,
              cachePolicy: cachePolicy,
        contextIdentifier: contextIdentifier,
        queue: queue,
        resultHandler: resultHandler)
    }
    
    @discardableResult
    public func perform<Mutation: GraphQLMutation>(mutation: Mutation,
                                                   publishResultToStore: Bool = true,
                                                   queue: DispatchQueue = .main,
                                                   resultHandler: GraphQLResultHandler<Mutation.Data>? = nil) -> Cancellable {
        perform(mutation: mutation,
        publishResultToStore: publishResultToStore,
        queue: queue,
        resultHandler: resultHandler)
    }
}

