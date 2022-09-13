// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPortfolioChartMetricsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPortfolioChartMetrics($profileId: Int!, $interestIds: [Int], $accessTokenIds: [Int], $accountIds: [Int], $categoryIds: [Int], $lttOnly: Boolean, $securityTypes: [String]) {
      get_portfolio_chart_previous_period_close(
        profile_id: $profileId
        interest_ids: $interestIds
        access_token_ids: $accessTokenIds
        account_ids: $accountIds
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

  public let operationName: String = "GetPortfolioChartMetrics"

  public var profileId: Int
  public var interestIds: [Int?]?
  public var accessTokenIds: [Int?]?
  public var accountIds: [Int?]?
  public var categoryIds: [Int?]?
  public var lttOnly: Bool?
  public var securityTypes: [String?]?

  public init(profileId: Int, interestIds: [Int?]? = nil, accessTokenIds: [Int?]? = nil, accountIds: [Int?]? = nil, categoryIds: [Int?]? = nil, lttOnly: Bool? = nil, securityTypes: [String?]? = nil) {
    self.profileId = profileId
    self.interestIds = interestIds
    self.accessTokenIds = accessTokenIds
    self.accountIds = accountIds
    self.categoryIds = categoryIds
    self.lttOnly = lttOnly
    self.securityTypes = securityTypes
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "interestIds": interestIds, "accessTokenIds": accessTokenIds, "accountIds": accountIds, "categoryIds": categoryIds, "lttOnly": lttOnly, "securityTypes": securityTypes]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("get_portfolio_chart_previous_period_close", arguments: ["profile_id": GraphQLVariable("profileId"), "interest_ids": GraphQLVariable("interestIds"), "access_token_ids": GraphQLVariable("accessTokenIds"), "account_ids": GraphQLVariable("accountIds"), "category_ids": GraphQLVariable("categoryIds"), "ltt_only": GraphQLVariable("lttOnly"), "security_types": GraphQLVariable("securityTypes")], type: .object(GetPortfolioChartPreviousPeriodClose.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getPortfolioChartPreviousPeriodClose: GetPortfolioChartPreviousPeriodClose? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "get_portfolio_chart_previous_period_close": getPortfolioChartPreviousPeriodClose.flatMap { (value: GetPortfolioChartPreviousPeriodClose) -> ResultMap in value.resultMap }])
    }

    public var getPortfolioChartPreviousPeriodClose: GetPortfolioChartPreviousPeriodClose? {
      get {
        return (resultMap["get_portfolio_chart_previous_period_close"] as? ResultMap).flatMap { GetPortfolioChartPreviousPeriodClose(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "get_portfolio_chart_previous_period_close")
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
