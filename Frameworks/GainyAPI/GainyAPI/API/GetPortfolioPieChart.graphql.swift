// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPortfolioPieChartQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPortfolioPieChart($profileId: Int!, $broker_ids: [String]) {
      get_portfolio_piechart(profile_id: $profileId, broker_ids: $broker_ids) {
        __typename
        weight
        entity_type
        relative_daily_change
        entity_name
        entity_id
        absolute_value
        absolute_daily_change
      }
    }
    """

  public let operationName: String = "GetPortfolioPieChart"

  public var profileId: Int
  public var broker_ids: [String?]?

  public init(profileId: Int, broker_ids: [String?]? = nil) {
    self.profileId = profileId
    self.broker_ids = broker_ids
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "broker_ids": broker_ids]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("get_portfolio_piechart", arguments: ["profile_id": GraphQLVariable("profileId"), "broker_ids": GraphQLVariable("broker_ids")], type: .list(.object(GetPortfolioPiechart.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getPortfolioPiechart: [GetPortfolioPiechart?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "get_portfolio_piechart": getPortfolioPiechart.flatMap { (value: [GetPortfolioPiechart?]) -> [ResultMap?] in value.map { (value: GetPortfolioPiechart?) -> ResultMap? in value.flatMap { (value: GetPortfolioPiechart) -> ResultMap in value.resultMap } } }])
    }

    public var getPortfolioPiechart: [GetPortfolioPiechart?]? {
      get {
        return (resultMap["get_portfolio_piechart"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetPortfolioPiechart?] in value.map { (value: ResultMap?) -> GetPortfolioPiechart? in value.flatMap { (value: ResultMap) -> GetPortfolioPiechart in GetPortfolioPiechart(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetPortfolioPiechart?]) -> [ResultMap?] in value.map { (value: GetPortfolioPiechart?) -> ResultMap? in value.flatMap { (value: GetPortfolioPiechart) -> ResultMap in value.resultMap } } }, forKey: "get_portfolio_piechart")
      }
    }

    public struct GetPortfolioPiechart: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PieChartDataPoint"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("weight", type: .scalar(Double.self)),
          GraphQLField("entity_type", type: .scalar(String.self)),
          GraphQLField("relative_daily_change", type: .scalar(Double.self)),
          GraphQLField("entity_name", type: .scalar(String.self)),
          GraphQLField("entity_id", type: .scalar(String.self)),
          GraphQLField("absolute_value", type: .scalar(Double.self)),
          GraphQLField("absolute_daily_change", type: .scalar(Double.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(weight: Double? = nil, entityType: String? = nil, relativeDailyChange: Double? = nil, entityName: String? = nil, entityId: String? = nil, absoluteValue: Double? = nil, absoluteDailyChange: Double? = nil) {
        self.init(unsafeResultMap: ["__typename": "PieChartDataPoint", "weight": weight, "entity_type": entityType, "relative_daily_change": relativeDailyChange, "entity_name": entityName, "entity_id": entityId, "absolute_value": absoluteValue, "absolute_daily_change": absoluteDailyChange])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var weight: Double? {
        get {
          return resultMap["weight"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "weight")
        }
      }

      public var entityType: String? {
        get {
          return resultMap["entity_type"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "entity_type")
        }
      }

      public var relativeDailyChange: Double? {
        get {
          return resultMap["relative_daily_change"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "relative_daily_change")
        }
      }

      public var entityName: String? {
        get {
          return resultMap["entity_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "entity_name")
        }
      }

      public var entityId: String? {
        get {
          return resultMap["entity_id"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "entity_id")
        }
      }

      public var absoluteValue: Double? {
        get {
          return resultMap["absolute_value"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "absolute_value")
        }
      }

      public var absoluteDailyChange: Double? {
        get {
          return resultMap["absolute_daily_change"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "absolute_daily_change")
        }
      }
    }
  }
}
