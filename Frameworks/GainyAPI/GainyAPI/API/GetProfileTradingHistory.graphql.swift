// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetProfileTradingHistoryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetProfileTradingHistory($profile_id: Int!, $types: [String!]!) {
      trading_history(
        where: {profile_id: {_eq: $profile_id}, type: {_in: $types}}
        order_by: {datetime: desc}
      ) {
        __typename
        amount
        datetime
        name
        tags
        type
      }
    }
    """

  public let operationName: String = "GetProfileTradingHistory"

  public var profile_id: Int
  public var types: [String]

  public init(profile_id: Int, types: [String]) {
    self.profile_id = profile_id
    self.types = types
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "types": types]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("trading_history", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profile_id")], "type": ["_in": GraphQLVariable("types")]], "order_by": ["datetime": "desc"]], type: .nonNull(.list(.nonNull(.object(TradingHistory.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingHistory: [TradingHistory]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "trading_history": tradingHistory.map { (value: TradingHistory) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_221122062016.trading_history"
    public var tradingHistory: [TradingHistory] {
      get {
        return (resultMap["trading_history"] as! [ResultMap]).map { (value: ResultMap) -> TradingHistory in TradingHistory(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: TradingHistory) -> ResultMap in value.resultMap }, forKey: "trading_history")
      }
    }

    public struct TradingHistory: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["trading_history"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("amount", type: .scalar(float8.self)),
          GraphQLField("datetime", type: .scalar(timestamptz.self)),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("tags", type: .scalar(json.self)),
          GraphQLField("type", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(amount: float8? = nil, datetime: timestamptz? = nil, name: String? = nil, tags: json? = nil, type: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "trading_history", "amount": amount, "datetime": datetime, "name": name, "tags": tags, "type": type])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var amount: float8? {
        get {
          return resultMap["amount"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "amount")
        }
      }

      public var datetime: timestamptz? {
        get {
          return resultMap["datetime"] as? timestamptz
        }
        set {
          resultMap.updateValue(newValue, forKey: "datetime")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var tags: json? {
        get {
          return resultMap["tags"] as? json
        }
        set {
          resultMap.updateValue(newValue, forKey: "tags")
        }
      }

      public var type: String? {
        get {
          return resultMap["type"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }
    }
  }
}
