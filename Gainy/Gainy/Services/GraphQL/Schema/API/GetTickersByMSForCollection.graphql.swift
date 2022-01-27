// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetTickersByMsForCollectionQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetTickersByMSForCollection($collectionId: Int!, $offset: Int!, $orderBy: order_by!) {
      ticker_collections(
        where: {collection_id: {_eq: $collectionId}}
        order_by: {ticker: {match_score: {match_score: $orderBy}, name: asc}}
        limit: 20
        offset: $offset
      ) {
        __typename
        ticker {
          __typename
          ...RemoteTickerDetails
        }
        collection_id
      }
    }
    """

  public let operationName: String = "GetTickersByMSForCollection"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RemoteTickerDetails.fragmentDefinition)
    return document
  }

  public var collectionId: Int
  public var offset: Int
  public var orderBy: order_by

  public init(collectionId: Int, offset: Int, orderBy: order_by) {
    self.collectionId = collectionId
    self.offset = offset
    self.orderBy = orderBy
  }

  public var variables: GraphQLMap? {
    return ["collectionId": collectionId, "offset": offset, "orderBy": orderBy]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("ticker_collections", arguments: ["where": ["collection_id": ["_eq": GraphQLVariable("collectionId")]], "order_by": ["ticker": ["match_score": ["match_score": GraphQLVariable("orderBy")], "name": "asc"]], "limit": 20, "offset": GraphQLVariable("offset")], type: .nonNull(.list(.nonNull(.object(TickerCollection.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tickerCollections: [TickerCollection]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "ticker_collections": tickerCollections.map { (value: TickerCollection) -> ResultMap in value.resultMap }])
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
          GraphQLField("ticker", type: .object(Ticker.selections)),
          GraphQLField("collection_id", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(ticker: Ticker? = nil, collectionId: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "ticker_collections", "ticker": ticker.flatMap { (value: Ticker) -> ResultMap in value.resultMap }, "collection_id": collectionId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// An object relationship
      public var ticker: Ticker? {
        get {
          return (resultMap["ticker"] as? ResultMap).flatMap { Ticker(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "ticker")
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

      public struct Ticker: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["tickers"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RemoteTickerDetails.self),
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

          public var remoteTickerDetails: RemoteTickerDetails {
            get {
              return RemoteTickerDetails(unsafeResultMap: resultMap)
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
