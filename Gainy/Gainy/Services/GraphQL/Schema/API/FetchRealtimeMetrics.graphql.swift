// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchRealtimeMetricsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchRealtimeMetrics($symbols: [String!]) {
      ticker_realtime_metrics(where: {symbol: {_in: $symbols}}) {
        __typename
        symbol
        actual_price
        absolute_daily_change
        relative_daily_change
      }
    }
    """

  public let operationName: String = "FetchRealtimeMetrics"

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
        GraphQLField("ticker_realtime_metrics", arguments: ["where": ["symbol": ["_in": GraphQLVariable("symbols")]]], type: .nonNull(.list(.nonNull(.object(TickerRealtimeMetric.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tickerRealtimeMetrics: [TickerRealtimeMetric]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "ticker_realtime_metrics": tickerRealtimeMetrics.map { (value: TickerRealtimeMetric) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_220401110900.ticker_realtime_metrics"
    public var tickerRealtimeMetrics: [TickerRealtimeMetric] {
      get {
        return (resultMap["ticker_realtime_metrics"] as! [ResultMap]).map { (value: ResultMap) -> TickerRealtimeMetric in TickerRealtimeMetric(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: TickerRealtimeMetric) -> ResultMap in value.resultMap }, forKey: "ticker_realtime_metrics")
      }
    }

    public struct TickerRealtimeMetric: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ticker_realtime_metrics"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("symbol", type: .scalar(String.self)),
          GraphQLField("actual_price", type: .scalar(float8.self)),
          GraphQLField("absolute_daily_change", type: .scalar(float8.self)),
          GraphQLField("relative_daily_change", type: .scalar(float8.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(symbol: String? = nil, actualPrice: float8? = nil, absoluteDailyChange: float8? = nil, relativeDailyChange: float8? = nil) {
        self.init(unsafeResultMap: ["__typename": "ticker_realtime_metrics", "symbol": symbol, "actual_price": actualPrice, "absolute_daily_change": absoluteDailyChange, "relative_daily_change": relativeDailyChange])
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

      public var actualPrice: float8? {
        get {
          return resultMap["actual_price"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "actual_price")
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

      public var relativeDailyChange: float8? {
        get {
          return resultMap["relative_daily_change"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "relative_daily_change")
        }
      }
    }
  }
}
