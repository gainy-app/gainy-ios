// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class DiscoverChartsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query DiscoverCharts($period: String!, $symbol: String!) {
      fetchChartData(period: $period, symbol: $symbol) {
        __typename
        volume
        open
        low
        datetime
        close
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
        GraphQLField("fetchChartData", arguments: ["period": GraphQLVariable("period"), "symbol": GraphQLVariable("symbol")], type: .list(.object(FetchChartDatum.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(fetchChartData: [FetchChartDatum?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "fetchChartData": fetchChartData.flatMap { (value: [FetchChartDatum?]) -> [ResultMap?] in value.map { (value: FetchChartDatum?) -> ResultMap? in value.flatMap { (value: FetchChartDatum) -> ResultMap in value.resultMap } } }])
    }

    public var fetchChartData: [FetchChartDatum?]? {
      get {
        return (resultMap["fetchChartData"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [FetchChartDatum?] in value.map { (value: ResultMap?) -> FetchChartDatum? in value.flatMap { (value: ResultMap) -> FetchChartDatum in FetchChartDatum(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [FetchChartDatum?]) -> [ResultMap?] in value.map { (value: FetchChartDatum?) -> ResultMap? in value.flatMap { (value: FetchChartDatum) -> ResultMap in value.resultMap } } }, forKey: "fetchChartData")
      }
    }

    public struct FetchChartDatum: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ChartDataPoint"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("volume", type: .scalar(Double.self)),
          GraphQLField("open", type: .scalar(Double.self)),
          GraphQLField("low", type: .scalar(Double.self)),
          GraphQLField("datetime", type: .scalar(String.self)),
          GraphQLField("close", type: .scalar(Double.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(volume: Double? = nil, `open`: Double? = nil, low: Double? = nil, datetime: String? = nil, close: Double? = nil) {
        self.init(unsafeResultMap: ["__typename": "ChartDataPoint", "volume": volume, "open": `open`, "low": low, "datetime": datetime, "close": close])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var volume: Double? {
        get {
          return resultMap["volume"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "volume")
        }
      }

      public var `open`: Double? {
        get {
          return resultMap["open"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "open")
        }
      }

      public var low: Double? {
        get {
          return resultMap["low"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "low")
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

      public var close: Double? {
        get {
          return resultMap["close"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "close")
        }
      }
    }
  }
}
