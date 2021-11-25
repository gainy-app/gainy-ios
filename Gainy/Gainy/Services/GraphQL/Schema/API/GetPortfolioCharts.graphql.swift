// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPortfolioChartsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPortfolioCharts($profileID: Int!, $period: String!) {
      portfolio_chart(
        where: {profile_id: {_eq: $profileID}, period: {_eq: $period}}
        order_by: {date: asc}
      ) {
        __typename
        date
        period
        value
      }
    }
    """

  public let operationName: String = "GetPortfolioCharts"

  public var profileID: Int
  public var period: String

  public init(profileID: Int, period: String) {
    self.profileID = profileID
    self.period = period
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID, "period": period]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("portfolio_chart", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileID")], "period": ["_eq": GraphQLVariable("period")]], "order_by": ["date": "asc"]], type: .nonNull(.list(.nonNull(.object(PortfolioChart.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(portfolioChart: [PortfolioChart]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "portfolio_chart": portfolioChart.map { (value: PortfolioChart) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "portfolio_chart"
    public var portfolioChart: [PortfolioChart] {
      get {
        return (resultMap["portfolio_chart"] as! [ResultMap]).map { (value: ResultMap) -> PortfolioChart in PortfolioChart(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: PortfolioChart) -> ResultMap in value.resultMap }, forKey: "portfolio_chart")
      }
    }

    public struct PortfolioChart: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["portfolio_chart"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("date", type: .scalar(timestamp.self)),
          GraphQLField("period", type: .scalar(String.self)),
          GraphQLField("value", type: .scalar(float8.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(date: timestamp? = nil, period: String? = nil, value: float8? = nil) {
        self.init(unsafeResultMap: ["__typename": "portfolio_chart", "date": date, "period": period, "value": value])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var date: timestamp? {
        get {
          return resultMap["date"] as? timestamp
        }
        set {
          resultMap.updateValue(newValue, forKey: "date")
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

      public var value: float8? {
        get {
          return resultMap["value"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "value")
        }
      }
    }
  }
}
