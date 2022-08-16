// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchLiveTickersDataQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchLiveTickersData($symbols: [String!]) {
      tickers(where: {symbol: {_in: $symbols}}) {
        __typename
        symbol
        realtime_metrics {
          __typename
          absolute_daily_change
          actual_price
          daily_volume
          relative_daily_change
          symbol
          time
        }
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
        GraphQLField("tickers", arguments: ["where": ["symbol": ["_in": GraphQLVariable("symbols")]]], type: .nonNull(.list(.nonNull(.object(Ticker.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tickers: [Ticker]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "tickers": tickers.map { (value: Ticker) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_220815100829.tickers"
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
          GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
          GraphQLField("realtime_metrics", type: .object(RealtimeMetric.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(symbol: String, realtimeMetrics: RealtimeMetric? = nil) {
        self.init(unsafeResultMap: ["__typename": "tickers", "symbol": symbol, "realtime_metrics": realtimeMetrics.flatMap { (value: RealtimeMetric) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var symbol: String {
        get {
          return resultMap["symbol"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "symbol")
        }
      }

      /// An object relationship
      public var realtimeMetrics: RealtimeMetric? {
        get {
          return (resultMap["realtime_metrics"] as? ResultMap).flatMap { RealtimeMetric(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "realtime_metrics")
        }
      }

      public struct RealtimeMetric: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ticker_realtime_metrics"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("absolute_daily_change", type: .scalar(float8.self)),
            GraphQLField("actual_price", type: .scalar(float8.self)),
            GraphQLField("daily_volume", type: .scalar(float8.self)),
            GraphQLField("relative_daily_change", type: .scalar(float8.self)),
            GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
            GraphQLField("time", type: .scalar(timestamp.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(absoluteDailyChange: float8? = nil, actualPrice: float8? = nil, dailyVolume: float8? = nil, relativeDailyChange: float8? = nil, symbol: String, time: timestamp? = nil) {
          self.init(unsafeResultMap: ["__typename": "ticker_realtime_metrics", "absolute_daily_change": absoluteDailyChange, "actual_price": actualPrice, "daily_volume": dailyVolume, "relative_daily_change": relativeDailyChange, "symbol": symbol, "time": time])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var absoluteDailyChange: float8? {
          get {
            return resultMap["absolute_daily_change"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "absolute_daily_change")
          }
        }

        public var actualPrice: float8? {
          get {
            return resultMap["actual_price"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "actual_price")
          }
        }

        public var dailyVolume: float8? {
          get {
            return resultMap["daily_volume"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "daily_volume")
          }
        }

        public var relativeDailyChange: float8? {
          get {
            return resultMap["relative_daily_change"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "relative_daily_change")
          }
        }

        public var symbol: String {
          get {
            return resultMap["symbol"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "symbol")
          }
        }

        public var time: timestamp? {
          get {
            return resultMap["time"] as? timestamp
          }
          set {
            resultMap.updateValue(newValue, forKey: "time")
          }
        }
      }
    }
  }
}
