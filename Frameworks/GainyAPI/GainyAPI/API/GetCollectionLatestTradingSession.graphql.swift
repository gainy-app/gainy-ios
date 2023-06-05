// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetCollectionLatestTradingSessionQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetCollectionLatestTradingSession($collection_uniq_id: String!) {
      collection_latest_trading_session(
        where: {collection_uniq_id: {_eq: $collection_uniq_id}}
      ) {
        __typename
        open_at
      }
    }
    """

  public let operationName: String = "GetCollectionLatestTradingSession"

  public var collection_uniq_id: String

  public init(collection_uniq_id: String) {
    self.collection_uniq_id = collection_uniq_id
  }

  public var variables: GraphQLMap? {
    return ["collection_uniq_id": collection_uniq_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("collection_latest_trading_session", arguments: ["where": ["collection_uniq_id": ["_eq": GraphQLVariable("collection_uniq_id")]]], type: .nonNull(.list(.nonNull(.object(CollectionLatestTradingSession.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collectionLatestTradingSession: [CollectionLatestTradingSession]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "collection_latest_trading_session": collectionLatestTradingSession.map { (value: CollectionLatestTradingSession) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230522161022.collection_latest_trading_session"
    public var collectionLatestTradingSession: [CollectionLatestTradingSession] {
      get {
        return (resultMap["collection_latest_trading_session"] as! [ResultMap]).map { (value: ResultMap) -> CollectionLatestTradingSession in CollectionLatestTradingSession(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: CollectionLatestTradingSession) -> ResultMap in value.resultMap }, forKey: "collection_latest_trading_session")
      }
    }

    public struct CollectionLatestTradingSession: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["collection_latest_trading_session"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("open_at", type: .scalar(timestamp.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(openAt: timestamp? = nil) {
        self.init(unsafeResultMap: ["__typename": "collection_latest_trading_session", "open_at": openAt])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var openAt: timestamp? {
        get {
          return resultMap["open_at"] as? timestamp
        }
        set {
          resultMap.updateValue(newValue, forKey: "open_at")
        }
      }
    }
  }
}
