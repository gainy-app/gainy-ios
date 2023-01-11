// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetTickerLinkedCollectionQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetTickerLinkedCollection($symbol: String!) {
      tickers(where: {symbol: {_eq: $symbol}}) {
        __typename
        ticker_collections(
          order_by: {collection: {metrics: {market_capitalization_sum: desc}}}
          where: {collection: {enabled: {_eq: "1"}}}
          limit: 1
        ) {
          __typename
          collection_id
          collection {
            __typename
            ...RemoteCollectionDetails
          }
        }
      }
    }
    """

  public let operationName: String = "GetTickerLinkedCollection"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RemoteCollectionDetails.fragmentDefinition)
    return document
  }

  public var symbol: String

  public init(symbol: String) {
    self.symbol = symbol
  }

  public var variables: GraphQLMap? {
    return ["symbol": symbol]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("tickers", arguments: ["where": ["symbol": ["_eq": GraphQLVariable("symbol")]]], type: .nonNull(.list(.nonNull(.object(Ticker.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tickers: [Ticker]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "tickers": tickers.map { (value: Ticker) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230111122944.tickers"
    public var tickers: [Ticker] {
      get {
        return (resultMap["tickers"] as! [ResultMap]).map { (value: ResultMap) -> Ticker in Ticker(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Ticker) -> ResultMap in value.resultMap }, forKey: "tickers")
      }
    }

    public struct Ticker: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["tickers"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ticker_collections", arguments: ["order_by": ["collection": ["metrics": ["market_capitalization_sum": "desc"]]], "where": ["collection": ["enabled": ["_eq": "1"]]], "limit": 1], type: .nonNull(.list(.nonNull(.object(TickerCollection.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(tickerCollections: [TickerCollection]) {
        self.init(unsafeResultMap: ["__typename": "tickers", "ticker_collections": tickerCollections.map { (value: TickerCollection) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// An array relationship
      public var tickerCollections: [TickerCollection] {
        get {
          return (resultMap["ticker_collections"] as! [ResultMap]).map { (value: ResultMap) -> TickerCollection in TickerCollection(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: TickerCollection) -> ResultMap in value.resultMap }, forKey: "ticker_collections")
        }
      }

      public struct TickerCollection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ticker_collections"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("collection_id", type: .scalar(Int.self)),
            GraphQLField("collection", type: .object(Collection.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(collectionId: Int? = nil, collection: Collection? = nil) {
          self.init(unsafeResultMap: ["__typename": "ticker_collections", "collection_id": collectionId, "collection": collection.flatMap { (value: Collection) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var collectionId: Int? {
          get {
            return resultMap["collection_id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "collection_id")
          }
        }

        /// An object relationship
        public var collection: Collection? {
          get {
            return (resultMap["collection"] as? ResultMap).flatMap { Collection(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "collection")
          }
        }

        public struct Collection: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["collections"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(RemoteCollectionDetails.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var remoteCollectionDetails: RemoteCollectionDetails {
              get {
                return RemoteCollectionDetails(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}
