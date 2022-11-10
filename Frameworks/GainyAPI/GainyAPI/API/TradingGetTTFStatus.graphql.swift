// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingGetProfileCollectionStatusQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query TradingGetProfileCollectionStatus($profile_id: Int!, $collection_id: Int!) {
      trading_profile_collection_status(
        where: {profile_id: {_eq: $profile_id}, collection_id: {_eq: $collection_id}}
      ) {
        __typename
        absolute_gain_1d
        absolute_gain_total
        actual_value
        relative_gain_1d
        relative_gain_total
        value_to_portfolio_value
      }
      app_trading_collection_versions(
        where: {profile_id: {_eq: $profile_id}, collection_id: {_eq: $collection_id}}
        limit: 3
      ) {
        __typename
        id
        created_at
        target_amount_delta
        history {
          __typename
          tags
        }
      }
    }
    """

  public let operationName: String = "TradingGetProfileCollectionStatus"

  public var profile_id: Int
  public var collection_id: Int

  public init(profile_id: Int, collection_id: Int) {
    self.profile_id = profile_id
    self.collection_id = collection_id
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "collection_id": collection_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("trading_profile_collection_status", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profile_id")], "collection_id": ["_eq": GraphQLVariable("collection_id")]]], type: .nonNull(.list(.nonNull(.object(TradingProfileCollectionStatus.selections))))),
        GraphQLField("app_trading_collection_versions", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profile_id")], "collection_id": ["_eq": GraphQLVariable("collection_id")]], "limit": 3], type: .nonNull(.list(.nonNull(.object(AppTradingCollectionVersion.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingProfileCollectionStatus: [TradingProfileCollectionStatus], appTradingCollectionVersions: [AppTradingCollectionVersion]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "trading_profile_collection_status": tradingProfileCollectionStatus.map { (value: TradingProfileCollectionStatus) -> ResultMap in value.resultMap }, "app_trading_collection_versions": appTradingCollectionVersions.map { (value: AppTradingCollectionVersion) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_221110054425.trading_profile_collection_status"
    public var tradingProfileCollectionStatus: [TradingProfileCollectionStatus] {
      get {
        return (resultMap["trading_profile_collection_status"] as! [ResultMap]).map { (value: ResultMap) -> TradingProfileCollectionStatus in TradingProfileCollectionStatus(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: TradingProfileCollectionStatus) -> ResultMap in value.resultMap }, forKey: "trading_profile_collection_status")
      }
    }

    /// fetch data from the table: "app.trading_collection_versions"
    public var appTradingCollectionVersions: [AppTradingCollectionVersion] {
      get {
        return (resultMap["app_trading_collection_versions"] as! [ResultMap]).map { (value: ResultMap) -> AppTradingCollectionVersion in AppTradingCollectionVersion(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppTradingCollectionVersion) -> ResultMap in value.resultMap }, forKey: "app_trading_collection_versions")
      }
    }

    public struct TradingProfileCollectionStatus: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["trading_profile_collection_status"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("absolute_gain_1d", type: .scalar(float8.self)),
          GraphQLField("absolute_gain_total", type: .scalar(float8.self)),
          GraphQLField("actual_value", type: .scalar(float8.self)),
          GraphQLField("relative_gain_1d", type: .scalar(float8.self)),
          GraphQLField("relative_gain_total", type: .scalar(float8.self)),
          GraphQLField("value_to_portfolio_value", type: .scalar(float8.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(absoluteGain_1d: float8? = nil, absoluteGainTotal: float8? = nil, actualValue: float8? = nil, relativeGain_1d: float8? = nil, relativeGainTotal: float8? = nil, valueToPortfolioValue: float8? = nil) {
        self.init(unsafeResultMap: ["__typename": "trading_profile_collection_status", "absolute_gain_1d": absoluteGain_1d, "absolute_gain_total": absoluteGainTotal, "actual_value": actualValue, "relative_gain_1d": relativeGain_1d, "relative_gain_total": relativeGainTotal, "value_to_portfolio_value": valueToPortfolioValue])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var absoluteGain_1d: float8? {
        get {
          return resultMap["absolute_gain_1d"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "absolute_gain_1d")
        }
      }

      public var absoluteGainTotal: float8? {
        get {
          return resultMap["absolute_gain_total"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "absolute_gain_total")
        }
      }

      public var actualValue: float8? {
        get {
          return resultMap["actual_value"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "actual_value")
        }
      }

      public var relativeGain_1d: float8? {
        get {
          return resultMap["relative_gain_1d"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "relative_gain_1d")
        }
      }

      public var relativeGainTotal: float8? {
        get {
          return resultMap["relative_gain_total"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "relative_gain_total")
        }
      }

      public var valueToPortfolioValue: float8? {
        get {
          return resultMap["value_to_portfolio_value"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "value_to_portfolio_value")
        }
      }
    }

    public struct AppTradingCollectionVersion: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_trading_collection_versions"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("created_at", type: .nonNull(.scalar(timestamptz.self))),
          GraphQLField("target_amount_delta", type: .nonNull(.scalar(numeric.self))),
          GraphQLField("history", type: .nonNull(.list(.nonNull(.object(History.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, createdAt: timestamptz, targetAmountDelta: numeric, history: [History]) {
        self.init(unsafeResultMap: ["__typename": "app_trading_collection_versions", "id": id, "created_at": createdAt, "target_amount_delta": targetAmountDelta, "history": history.map { (value: History) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var createdAt: timestamptz {
        get {
          return resultMap["created_at"]! as! timestamptz
        }
        set {
          resultMap.updateValue(newValue, forKey: "created_at")
        }
      }

      public var targetAmountDelta: numeric {
        get {
          return resultMap["target_amount_delta"]! as! numeric
        }
        set {
          resultMap.updateValue(newValue, forKey: "target_amount_delta")
        }
      }

      /// An array relationship
      public var history: [History] {
        get {
          return (resultMap["history"] as! [ResultMap]).map { (value: ResultMap) -> History in History(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: History) -> ResultMap in value.resultMap }, forKey: "history")
        }
      }

      public struct History: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["trading_history"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("tags", type: .scalar(json.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(tags: json? = nil) {
          self.init(unsafeResultMap: ["__typename": "trading_history", "tags": tags])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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
      }
    }
  }
}
