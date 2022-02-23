// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class DiscoverChartsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query DiscoverCharts($period: String!, $symbol: String!) {
      chart(
        where: {symbol: {_eq: $symbol}, period: {_eq: $period}}
        order_by: {datetime: asc}
      ) {
        __typename
        symbol
        datetime
        period
        open
        high
        low
        close
        adjusted_close
        volume
      }
    }
    """

  public let operationName: String = "DiscoverCharts"

  public var period: String
  public var symbol: String

  public init(period: String, symbol: String) {
    self.period = period
    self.symbol = symbol
  }

  public var variables: GraphQLMap? {
    return ["period": period, "symbol": symbol]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("chart", arguments: ["where": ["symbol": ["_eq": GraphQLVariable("symbol")], "period": ["_eq": GraphQLVariable("period")]], "order_by": ["datetime": "asc"]], type: .nonNull(.list(.nonNull(.object(Chart.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(chart: [Chart]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "chart": chart.map { (value: Chart) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_220222145854.chart"
    public var chart: [Chart] {
      get {
        return (resultMap["chart"] as! [ResultMap]).map { (value: ResultMap) -> Chart in Chart(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Chart) -> ResultMap in value.resultMap }, forKey: "chart")
      }
    }

    public struct Chart: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["chart"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("symbol", type: .scalar(String.self)),
          GraphQLField("datetime", type: .scalar(timestamp.self)),
          GraphQLField("period", type: .scalar(String.self)),
          GraphQLField("open", type: .scalar(float8.self)),
          GraphQLField("high", type: .scalar(float8.self)),
          GraphQLField("low", type: .scalar(float8.self)),
          GraphQLField("close", type: .scalar(float8.self)),
          GraphQLField("adjusted_close", type: .scalar(float8.self)),
          GraphQLField("volume", type: .scalar(float8.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(symbol: String? = nil, datetime: timestamp? = nil, period: String? = nil, `open`: float8? = nil, high: float8? = nil, low: float8? = nil, close: float8? = nil, adjustedClose: float8? = nil, volume: float8? = nil) {
        self.init(unsafeResultMap: ["__typename": "chart", "symbol": symbol, "datetime": datetime, "period": period, "open": `open`, "high": high, "low": low, "close": close, "adjusted_close": adjustedClose, "volume": volume])
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

      public var datetime: timestamp? {
        get {
          return resultMap["datetime"] as? timestamp
        }
        set {
          resultMap.updateValue(newValue, forKey: "datetime")
        }
      }

      public var period: String? {
        get {
          return resultMap["period"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "period")
        }
      }

      public var `open`: float8? {
        get {
          return resultMap["open"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "open")
        }
      }

      public var high: float8? {
        get {
          return resultMap["high"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "high")
        }
      }

      public var low: float8? {
        get {
          return resultMap["low"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "low")
        }
      }

      public var close: float8? {
        get {
          return resultMap["close"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "close")
        }
      }

      public var adjustedClose: float8? {
        get {
          return resultMap["adjusted_close"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "adjusted_close")
        }
      }

      public var volume: float8? {
        get {
          return resultMap["volume"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "volume")
        }
      }
    }
  }
}
