// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingCancelStockPendingOrderMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation TradingCancelStockPendingOrder($profile_id: Int!, $trading_order_id: Int!) {
      trading_cancel_pending_order(
        profile_id: $profile_id
        trading_order_id: $trading_order_id
      ) {
        __typename
        trading_order_id
      }
    }
    """

  public let operationName: String = "TradingCancelStockPendingOrder"

  public var profile_id: Int
  public var trading_order_id: Int

  public init(profile_id: Int, trading_order_id: Int) {
    self.profile_id = profile_id
    self.trading_order_id = trading_order_id
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "trading_order_id": trading_order_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("trading_cancel_pending_order", arguments: ["profile_id": GraphQLVariable("profile_id"), "trading_order_id": GraphQLVariable("trading_order_id")], type: .object(TradingCancelPendingOrder.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingCancelPendingOrder: TradingCancelPendingOrder? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "trading_cancel_pending_order": tradingCancelPendingOrder.flatMap { (value: TradingCancelPendingOrder) -> ResultMap in value.resultMap }])
    }

    public var tradingCancelPendingOrder: TradingCancelPendingOrder? {
      get {
        return (resultMap["trading_cancel_pending_order"] as? ResultMap).flatMap { TradingCancelPendingOrder(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "trading_cancel_pending_order")
      }
    }

    public struct TradingCancelPendingOrder: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["TradingCancelPendingOrderOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("trading_order_id", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(tradingOrderId: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "TradingCancelPendingOrderOutput", "trading_order_id": tradingOrderId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var tradingOrderId: Int? {
        get {
          return resultMap["trading_order_id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "trading_order_id")
        }
      }
    }
  }
}
