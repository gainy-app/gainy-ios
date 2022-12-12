// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingCreateStockOrderMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation TradingCreateStockOrder($profile_id: Int!, $symbol: String!, $target_amount_delta: Float!) {
      trading_create_stock_order(
        profile_id: $profile_id
        symbol: $symbol
        target_amount_delta: $target_amount_delta
      ) {
        __typename
        trading_order_id
      }
    }
    """

  public let operationName: String = "TradingCreateStockOrder"

  public var profile_id: Int
  public var symbol: String
  public var target_amount_delta: Double

  public init(profile_id: Int, symbol: String, target_amount_delta: Double) {
    self.profile_id = profile_id
    self.symbol = symbol
    self.target_amount_delta = target_amount_delta
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "symbol": symbol, "target_amount_delta": target_amount_delta]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("trading_create_stock_order", arguments: ["profile_id": GraphQLVariable("profile_id"), "symbol": GraphQLVariable("symbol"), "target_amount_delta": GraphQLVariable("target_amount_delta")], type: .object(TradingCreateStockOrder.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingCreateStockOrder: TradingCreateStockOrder? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "trading_create_stock_order": tradingCreateStockOrder.flatMap { (value: TradingCreateStockOrder) -> ResultMap in value.resultMap }])
    }

    public var tradingCreateStockOrder: TradingCreateStockOrder? {
      get {
        return (resultMap["trading_create_stock_order"] as? ResultMap).flatMap { TradingCreateStockOrder(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "trading_create_stock_order")
      }
    }

    public struct TradingCreateStockOrder: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["TradingCreateStockOrderOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("trading_order_id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(tradingOrderId: Int) {
        self.init(unsafeResultMap: ["__typename": "TradingCreateStockOrderOutput", "trading_order_id": tradingOrderId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var tradingOrderId: Int {
        get {
          return resultMap["trading_order_id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "trading_order_id")
        }
      }
    }
  }
}
