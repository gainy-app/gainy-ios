// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPortfolioChartsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPortfolioCharts($profileID: Int!, $period: String!, $dateG: timestamp!, $dateL: timestamp!) {
      portfolio_chart(
        where: {profile_id: {_eq: $profileID}, period: {_eq: $period}, datetime: {_gte: $dateG, _lte: $dateL}}
        order_by: {datetime: asc}
      ) {
        __typename
        datetime
        period
        value
      }
    }
    """

  public let operationName: String = "GetPortfolioCharts"

  public var profileID: Int
  public var period: String
  public var dateG: timestamp
  public var dateL: timestamp

  public init(profileID: Int, period: String, dateG: timestamp, dateL: timestamp) {
    self.profileID = profileID
    self.period = period
    self.dateG = dateG
    self.dateL = dateL
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID, "period": period, "dateG": dateG, "dateL": dateL]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("portfolio_chart", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileID")], "period": ["_eq": GraphQLVariable("period")], "datetime": ["_gte": GraphQLVariable("dateG"), "_lte": GraphQLVariable("dateL")]], "order_by": ["datetime": "asc"]], type: .nonNull(.list(.nonNull(.object(PortfolioChart.selections))))),
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
          GraphQLField("datetime", type: .scalar(timestamp.self)),
          GraphQLField("period", type: .scalar(String.self)),
          GraphQLField("value", type: .scalar(float8.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(datetime: timestamp? = nil, period: String? = nil, value: float8? = nil) {
        self.init(unsafeResultMap: ["__typename": "portfolio_chart", "datetime": datetime, "period": period, "value": value])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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
