// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingGetStockHistoryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query TradingGetStockHistory($profile_id: Int!, $symbol: String!) {
      app_trading_orders(
        where: {profile_id: {_eq: $profile_id}, symbol: {_eq: $symbol}}
        limit: 3
        order_by: {created_at: desc}
      ) {
        __typename
        id
        created_at
        target_amount_delta
        history {
          __typename
          ...TradingHistoryFrag
        }
      }
    }
    """

  public let operationName: String = "TradingGetStockHistory"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + TradingHistoryFrag.fragmentDefinition)
    return document
  }

  public var profile_id: Int
  public var symbol: String

  public init(profile_id: Int, symbol: String) {
    self.profile_id = profile_id
    self.symbol = symbol
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "symbol": symbol]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("app_trading_orders", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profile_id")], "symbol": ["_eq": GraphQLVariable("symbol")]], "limit": 3, "order_by": ["created_at": "desc"]], type: .nonNull(.list(.nonNull(.object(AppTradingOrder.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appTradingOrders: [AppTradingOrder]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_trading_orders": appTradingOrders.map { (value: AppTradingOrder) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.trading_orders"
    public var appTradingOrders: [AppTradingOrder] {
      get {
        return (resultMap["app_trading_orders"] as! [ResultMap]).map { (value: ResultMap) -> AppTradingOrder in AppTradingOrder(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppTradingOrder) -> ResultMap in value.resultMap }, forKey: "app_trading_orders")
      }
    }

    public struct AppTradingOrder: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_trading_orders"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("created_at", type: .nonNull(.scalar(timestamptz.self))),
          GraphQLField("target_amount_delta", type: .scalar(numeric.self)),
          GraphQLField("history", type: .object(History.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, createdAt: timestamptz, targetAmountDelta: numeric? = nil, history: History? = nil) {
        self.init(unsafeResultMap: ["__typename": "app_trading_orders", "id": id, "created_at": createdAt, "target_amount_delta": targetAmountDelta, "history": history.flatMap { (value: History) -> ResultMap in value.resultMap }])
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

      public var targetAmountDelta: numeric? {
        get {
          return resultMap["target_amount_delta"] as? numeric
        }
        set {
          resultMap.updateValue(newValue, forKey: "target_amount_delta")
        }
      }

      /// An object relationship
      public var history: History? {
        get {
          return (resultMap["history"] as? ResultMap).flatMap { History(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "history")
        }
      }

      public struct History: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["trading_history"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(TradingHistoryFrag.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var tradingHistoryFrag: TradingHistoryFrag {
            get {
              return TradingHistoryFrag(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}
