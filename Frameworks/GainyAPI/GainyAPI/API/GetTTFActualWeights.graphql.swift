// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetCollectionTickerActualWeightsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetCollectionTickerActualWeights($collection_id: Int!) {
      trading_collection_tickers(where: {collection_id: {_eq: $collection_id}}) {
        __typename
        symbol
        weight
      }
    }
    """

  public let operationName: String = "GetCollectionTickerActualWeights"

  public var collection_id: Int

  public init(collection_id: Int) {
    self.collection_id = collection_id
  }

  public var variables: GraphQLMap? {
    return ["collection_id": collection_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("trading_collection_tickers", arguments: ["where": ["collection_id": ["_eq": GraphQLVariable("collection_id")]]], type: .nonNull(.list(.nonNull(.object(TradingCollectionTicker.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingCollectionTickers: [TradingCollectionTicker]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "trading_collection_tickers": tradingCollectionTickers.map { (value: TradingCollectionTicker) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230503100430.trading_collection_tickers"
    public var tradingCollectionTickers: [TradingCollectionTicker] {
      get {
        return (resultMap["trading_collection_tickers"] as! [ResultMap]).map { (value: ResultMap) -> TradingCollectionTicker in TradingCollectionTicker(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: TradingCollectionTicker) -> ResultMap in value.resultMap }, forKey: "trading_collection_tickers")
      }
    }

    public struct TradingCollectionTicker: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["trading_collection_tickers"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("symbol", type: .scalar(String.self)),
          GraphQLField("weight", type: .scalar(numeric.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(symbol: String? = nil, weight: numeric? = nil) {
        self.init(unsafeResultMap: ["__typename": "trading_collection_tickers", "symbol": symbol, "weight": weight])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var symbol: String? {
        get {
          return resultMap["symbol"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "symbol")
        }
      }

      public var weight: numeric? {
        get {
          return resultMap["weight"] as? numeric
        }
        set {
          resultMap.updateValue(newValue, forKey: "weight")
        }
      }
    }
  }
}
