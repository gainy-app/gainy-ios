// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingGetTtfStatusQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query TradingGetTTFStatus($profile_id: Int!, $collection_id: Int!) {
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
    }
    """

  public let operationName: String = "TradingGetTTFStatus"

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
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingProfileCollectionStatus: [TradingProfileCollectionStatus]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "trading_profile_collection_status": tradingProfileCollectionStatus.map { (value: TradingProfileCollectionStatus) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_221227091811.trading_profile_collection_status"
    public var tradingProfileCollectionStatus: [TradingProfileCollectionStatus] {
      get {
        return (resultMap["trading_profile_collection_status"] as! [ResultMap]).map { (value: ResultMap) -> TradingProfileCollectionStatus in TradingProfileCollectionStatus(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: TradingProfileCollectionStatus) -> ResultMap in value.resultMap }, forKey: "trading_profile_collection_status")
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
  }
}
