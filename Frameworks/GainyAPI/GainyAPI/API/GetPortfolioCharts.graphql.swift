// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPortfolioChartsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPortfolioCharts($profileId: Int!, $periods: [String]!, $broker_ids: [String], $interestIds: [Int], $categoryIds: [Int], $lttOnly: Boolean, $securityTypes: [String]) {
      get_portfolio_chart(
        profile_id: $profileId
        periods: $periods
        broker_ids: $broker_ids
        interest_ids: $interestIds
        category_ids: $categoryIds
        ltt_only: $lttOnly
        security_types: $securityTypes
      ) {
        __typename
        datetime
        period
        open
        high
        low
        adjusted_close
      }
      get_portfolio_chart_previous_period_close(
        profile_id: $profileId
        broker_ids: $broker_ids
        interest_ids: $interestIds
        category_ids: $categoryIds
        ltt_only: $lttOnly
        security_types: $securityTypes
      ) {
        __typename
        prev_close_1d
        prev_close_1w
        prev_close_1m
        prev_close_3m
        prev_close_1y
        prev_close_5y
      }
    }
    """

  public let operationName: String = "GetPortfolioCharts"

  public var profileId: Int
  public var periods: [String?]
  public var broker_ids: [String?]?
  public var interestIds: [Int?]?
  public var categoryIds: [Int?]?
  public var lttOnly: Bool?
  public var securityTypes: [String?]?

  public init(profileId: Int, periods: [String?], broker_ids: [String?]? = nil, interestIds: [Int?]? = nil, categoryIds: [Int?]? = nil, lttOnly: Bool? = nil, securityTypes: [String?]? = nil) {
    self.profileId = profileId
    self.periods = periods
    self.broker_ids = broker_ids
    self.interestIds = interestIds
    self.categoryIds = categoryIds
    self.lttOnly = lttOnly
    self.securityTypes = securityTypes
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "periods": periods, "broker_ids": broker_ids, "interestIds": interestIds, "categoryIds": categoryIds, "lttOnly": lttOnly, "securityTypes": securityTypes]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("get_portfolio_chart", arguments: ["profile_id": GraphQLVariable("profileId"), "periods": GraphQLVariable("periods"), "broker_ids": GraphQLVariable("broker_ids"), "interest_ids": GraphQLVariable("interestIds"), "category_ids": GraphQLVariable("categoryIds"), "ltt_only": GraphQLVariable("lttOnly"), "security_types": GraphQLVariable("securityTypes")], type: .list(.object(GetPortfolioChart.selections))),
        GraphQLField("get_portfolio_chart_previous_period_close", arguments: ["profile_id": GraphQLVariable("profileId"), "broker_ids": GraphQLVariable("broker_ids"), "interest_ids": GraphQLVariable("interestIds"), "category_ids": GraphQLVariable("categoryIds"), "ltt_only": GraphQLVariable("lttOnly"), "security_types": GraphQLVariable("securityTypes")], type: .object(GetPortfolioChartPreviousPeriodClose.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getPortfolioChart: [GetPortfolioChart?]? = nil, getPortfolioChartPreviousPeriodClose: GetPortfolioChartPreviousPeriodClose? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "get_portfolio_chart": getPortfolioChart.flatMap { (value: [GetPortfolioChart?]) -> [ResultMap?] in value.map { (value: GetPortfolioChart?) -> ResultMap? in value.flatMap { (value: GetPortfolioChart) -> ResultMap in value.resultMap } } }, "get_portfolio_chart_previous_period_close": getPortfolioChartPreviousPeriodClose.flatMap { (value: GetPortfolioChartPreviousPeriodClose) -> ResultMap in value.resultMap }])
    }

    public var getPortfolioChart: [GetPortfolioChart?]? {
      get {
        return (resultMap["get_portfolio_chart"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetPortfolioChart?] in value.map { (value: ResultMap?) -> GetPortfolioChart? in value.flatMap { (value: ResultMap) -> GetPortfolioChart in GetPortfolioChart(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetPortfolioChart?]) -> [ResultMap?] in value.map { (value: GetPortfolioChart?) -> ResultMap? in value.flatMap { (value: GetPortfolioChart) -> ResultMap in value.resultMap } } }, forKey: "get_portfolio_chart")
      }
    }

    public var getPortfolioChartPreviousPeriodClose: GetPortfolioChartPreviousPeriodClose? {
      get {
        return (resultMap["get_portfolio_chart_previous_period_close"] as? ResultMap).flatMap { GetPortfolioChartPreviousPeriodClose(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "get_portfolio_chart_previous_period_close")
      }
    }

    public struct GetPortfolioChart: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ChartDataPoint"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("datetime", type: .scalar(String.self)),
          GraphQLField("period", type: .scalar(String.self)),
          GraphQLField("open", type: .scalar(Double.self)),
          GraphQLField("high", type: .scalar(Double.self)),
          GraphQLField("low", type: .scalar(Double.self)),
          GraphQLField("adjusted_close", type: .scalar(Double.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(datetime: String? = nil, period: String? = nil, `open`: Double? = nil, high: Double? = nil, low: Double? = nil, adjustedClose: Double? = nil) {
        self.init(unsafeResultMap: ["__typename": "ChartDataPoint", "datetime": datetime, "period": period, "open": `open`, "high": high, "low": low, "adjusted_close": adjustedClose])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      public var period: String? {
        get {
          return resultMap["period"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "period")
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

      public var high: Double? {
        get {
          return resultMap["high"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "high")
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

      public var adjustedClose: Double? {
        get {
          return resultMap["adjusted_close"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "adjusted_close")
        }
      }
    }

    public struct GetPortfolioChartPreviousPeriodClose: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PortfolioChartPreviousPeriodClose"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("prev_close_1d", type: .scalar(Double.self)),
          GraphQLField("prev_close_1w", type: .scalar(Double.self)),
          GraphQLField("prev_close_1m", type: .scalar(Double.self)),
          GraphQLField("prev_close_3m", type: .scalar(Double.self)),
          GraphQLField("prev_close_1y", type: .scalar(Double.self)),
          GraphQLField("prev_close_5y", type: .scalar(Double.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(prevClose_1d: Double? = nil, prevClose_1w: Double? = nil, prevClose_1m: Double? = nil, prevClose_3m: Double? = nil, prevClose_1y: Double? = nil, prevClose_5y: Double? = nil) {
        self.init(unsafeResultMap: ["__typename": "PortfolioChartPreviousPeriodClose", "prev_close_1d": prevClose_1d, "prev_close_1w": prevClose_1w, "prev_close_1m": prevClose_1m, "prev_close_3m": prevClose_3m, "prev_close_1y": prevClose_1y, "prev_close_5y": prevClose_5y])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var prevClose_1d: Double? {
        get {
          return resultMap["prev_close_1d"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "prev_close_1d")
        }
      }

      public var prevClose_1w: Double? {
        get {
          return resultMap["prev_close_1w"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "prev_close_1w")
        }
      }

      public var prevClose_1m: Double? {
        get {
          return resultMap["prev_close_1m"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "prev_close_1m")
        }
      }

      public var prevClose_3m: Double? {
        get {
          return resultMap["prev_close_3m"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "prev_close_3m")
        }
      }

      public var prevClose_1y: Double? {
        get {
          return resultMap["prev_close_1y"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "prev_close_1y")
        }
      }

      public var prevClose_5y: Double? {
        get {
          return resultMap["prev_close_5y"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "prev_close_5y")
        }
      }
    }
  }
}
