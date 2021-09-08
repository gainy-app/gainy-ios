// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchLiveTickersDataQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchLiveTickersData($symbols: [String!]) {
      fetchLivePrices(symbols: $symbols) {
        __typename
        close
        daily_change
        daily_change_p
        datetime
        symbol
      }
    }
    """

  public let operationName: String = "FetchLiveTickersData"

  public var symbols: [String]?

  public init(symbols: [String]?) {
    self.symbols = symbols
  }

  public var variables: GraphQLMap? {
    return ["symbols": symbols]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("fetchLivePrices", arguments: ["symbols": GraphQLVariable("symbols")], type: .list(.object(FetchLivePrice.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(fetchLivePrices: [FetchLivePrice?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "fetchLivePrices": fetchLivePrices.flatMap { (value: [FetchLivePrice?]) -> [ResultMap?] in value.map { (value: FetchLivePrice?) -> ResultMap? in value.flatMap { (value: FetchLivePrice) -> ResultMap in value.resultMap } } }])
    }

    public var fetchLivePrices: [FetchLivePrice?]? {
      get {
        return (resultMap["fetchLivePrices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [FetchLivePrice?] in value.map { (value: ResultMap?) -> FetchLivePrice? in value.flatMap { (value: ResultMap) -> FetchLivePrice in FetchLivePrice(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [FetchLivePrice?]) -> [ResultMap?] in value.map { (value: FetchLivePrice?) -> ResultMap? in value.flatMap { (value: FetchLivePrice) -> ResultMap in value.resultMap } } }, forKey: "fetchLivePrices")
      }
    }

    public struct FetchLivePrice: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["LiveStockPriceData"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("close", type: .scalar(Double.self)),
          GraphQLField("daily_change", type: .scalar(Double.self)),
          GraphQLField("daily_change_p", type: .scalar(Double.self)),
          GraphQLField("datetime", type: .scalar(String.self)),
          GraphQLField("symbol", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(close: Double? = nil, dailyChange: Double? = nil, dailyChangeP: Double? = nil, datetime: String? = nil, symbol: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "LiveStockPriceData", "close": close, "daily_change": dailyChange, "daily_change_p": dailyChangeP, "datetime": datetime, "symbol": symbol])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var close: Double? {
        get {
          return resultMap["close"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "close")
        }
      }

      public var dailyChange: Double? {
        get {
          return resultMap["daily_change"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "daily_change")
        }
      }

      public var dailyChangeP: Double? {
        get {
          return resultMap["daily_change_p"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "daily_change_p")
        }
      }

      public var datetime: String? {
        get {
          return resultMap["datetime"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "datetime")
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
    }
  }
}
