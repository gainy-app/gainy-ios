// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TtfTradingWithdrawFundsMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation TTFTradingWithdrawFunds($profile_id: Int!, $collection_id: Int!, $weights: [TickerWeight]!, $target_amount_delta: Float!) {
      trading_reconfigure_collection_holdings(
        profile_id: $profile_id
        collection_id: $collection_id
        weights: $weights
        target_amount_delta: $target_amount_delta
      ) {
        __typename
        trading_collection_version_id
      }
    }
    """

  public let operationName: String = "TTFTradingWithdrawFunds"

  public var profile_id: Int
  public var collection_id: Int
  public var weights: [TickerWeight?]
  public var target_amount_delta: Double

  public init(profile_id: Int, collection_id: Int, weights: [TickerWeight?], target_amount_delta: Double) {
    self.profile_id = profile_id
    self.collection_id = collection_id
    self.weights = weights
    self.target_amount_delta = target_amount_delta
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "collection_id": collection_id, "weights": weights, "target_amount_delta": target_amount_delta]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("trading_reconfigure_collection_holdings", arguments: ["profile_id": GraphQLVariable("profile_id"), "collection_id": GraphQLVariable("collection_id"), "weights": GraphQLVariable("weights"), "target_amount_delta": GraphQLVariable("target_amount_delta")], type: .object(TradingReconfigureCollectionHolding.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingReconfigureCollectionHoldings: TradingReconfigureCollectionHolding? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "trading_reconfigure_collection_holdings": tradingReconfigureCollectionHoldings.flatMap { (value: TradingReconfigureCollectionHolding) -> ResultMap in value.resultMap }])
    }

    public var tradingReconfigureCollectionHoldings: TradingReconfigureCollectionHolding? {
      get {
        return (resultMap["trading_reconfigure_collection_holdings"] as? ResultMap).flatMap { TradingReconfigureCollectionHolding(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "trading_reconfigure_collection_holdings")
      }
    }

    public struct TradingReconfigureCollectionHolding: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["TradingCollectionVersionOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("trading_collection_version_id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(tradingCollectionVersionId: Int) {
        self.init(unsafeResultMap: ["__typename": "TradingCollectionVersionOutput", "trading_collection_version_id": tradingCollectionVersionId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var tradingCollectionVersionId: Int {
        get {
          return resultMap["trading_collection_version_id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "trading_collection_version_id")
        }
      }
    }
  }
}
