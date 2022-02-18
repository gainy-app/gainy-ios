// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchStockMedianQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchStockMedian($industryId: bigint!, $period: String!) {
      industry_median_chart(
        where: {industry_id: {_eq: $industryId}, period: {_eq: $period}}
      ) {
        __typename
        period
        median_price
        datetime
      }
    }
    """

  public let operationName: String = "FetchStockMedian"

  public var industryId: bigint
  public var period: String

  public init(industryId: bigint, period: String) {
    self.industryId = industryId
    self.period = period
  }

  public var variables: GraphQLMap? {
    return ["industryId": industryId, "period": period]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("industry_median_chart", arguments: ["where": ["industry_id": ["_eq": GraphQLVariable("industryId")], "period": ["_eq": GraphQLVariable("period")]]], type: .nonNull(.list(.nonNull(.object(IndustryMedianChart.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(industryMedianChart: [IndustryMedianChart]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "industry_median_chart": industryMedianChart.map { (value: IndustryMedianChart) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_220217172253.industry_median_chart"
    public var industryMedianChart: [IndustryMedianChart] {
      get {
        return (resultMap["industry_median_chart"] as! [ResultMap]).map { (value: ResultMap) -> IndustryMedianChart in IndustryMedianChart(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: IndustryMedianChart) -> ResultMap in value.resultMap }, forKey: "industry_median_chart")
      }
    }

    public struct IndustryMedianChart: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["industry_median_chart"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("period", type: .scalar(String.self)),
          GraphQLField("median_price", type: .scalar(float8.self)),
          GraphQLField("datetime", type: .scalar(timestamp.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(period: String? = nil, medianPrice: float8? = nil, datetime: timestamp? = nil) {
        self.init(unsafeResultMap: ["__typename": "industry_median_chart", "period": period, "median_price": medianPrice, "datetime": datetime])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      public var medianPrice: float8? {
        get {
          return resultMap["median_price"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "median_price")
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
    }
  }
}
