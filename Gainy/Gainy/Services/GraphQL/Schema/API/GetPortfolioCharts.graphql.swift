// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPortfolioChartsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPortfolioCharts($profileId: Int!, $periods: [String]!, $interestIds: [Int], $accessTokenIds: [Int], $accountIds: [Int], $categoryIds: [Int], $institutionIds: [Int], $lttOnly: Boolean, $securityTypes: [String]) {
      get_portfolio_chart(
        profile_id: $profileId
        periods: $periods
        interest_ids: $interestIds
        access_token_ids: $accessTokenIds
        account_ids: $accountIds
        category_ids: $categoryIds
        institution_ids: $institutionIds
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
    }
    """

  public let operationName: String = "GetPortfolioCharts"

  public var profileId: Int
  public var periods: [String?]
  public var interestIds: [Int?]?
  public var accessTokenIds: [Int?]?
  public var accountIds: [Int?]?
  public var categoryIds: [Int?]?
  public var institutionIds: [Int?]?
  public var lttOnly: Bool?
  public var securityTypes: [String?]?

  public init(profileId: Int, periods: [String?], interestIds: [Int?]? = nil, accessTokenIds: [Int?]? = nil, accountIds: [Int?]? = nil, categoryIds: [Int?]? = nil, institutionIds: [Int?]? = nil, lttOnly: Bool? = nil, securityTypes: [String?]? = nil) {
    self.profileId = profileId
    self.periods = periods
    self.interestIds = interestIds
    self.accessTokenIds = accessTokenIds
    self.accountIds = accountIds
    self.categoryIds = categoryIds
    self.institutionIds = institutionIds
    self.lttOnly = lttOnly
    self.securityTypes = securityTypes
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "periods": periods, "interestIds": interestIds, "accessTokenIds": accessTokenIds, "accountIds": accountIds, "categoryIds": categoryIds, "institutionIds": institutionIds, "lttOnly": lttOnly, "securityTypes": securityTypes]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("get_portfolio_chart", arguments: ["profile_id": GraphQLVariable("profileId"), "periods": GraphQLVariable("periods"), "interest_ids": GraphQLVariable("interestIds"), "access_token_ids": GraphQLVariable("accessTokenIds"), "account_ids": GraphQLVariable("accountIds"), "category_ids": GraphQLVariable("categoryIds"), "institution_ids": GraphQLVariable("institutionIds"), "ltt_only": GraphQLVariable("lttOnly"), "security_types": GraphQLVariable("securityTypes")], type: .list(.object(GetPortfolioChart.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getPortfolioChart: [GetPortfolioChart?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "get_portfolio_chart": getPortfolioChart.flatMap { (value: [GetPortfolioChart?]) -> [ResultMap?] in value.map { (value: GetPortfolioChart?) -> ResultMap? in value.flatMap { (value: GetPortfolioChart) -> ResultMap in value.resultMap } } }])
    }

    public var getPortfolioChart: [GetPortfolioChart?]? {
      get {
        return (resultMap["get_portfolio_chart"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetPortfolioChart?] in value.map { (value: ResultMap?) -> GetPortfolioChart? in value.flatMap { (value: ResultMap) -> GetPortfolioChart in GetPortfolioChart(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetPortfolioChart?]) -> [ResultMap?] in value.map { (value: GetPortfolioChart?) -> ResultMap? in value.flatMap { (value: GetPortfolioChart) -> ResultMap in value.resultMap } } }, forKey: "get_portfolio_chart")
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
  }
}
