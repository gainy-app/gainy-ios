// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingGetProfilePendingFlowQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query TradingGetProfilePendingFlow($profile_id: Int!) {
      app_trading_money_flow(
        where: {status: {_eq: "PENDING"}, profile_id: {_eq: $profile_id}}
      ) {
        __typename
        amount
        created_at
      }
    }
    """

  public let operationName: String = "TradingGetProfilePendingFlow"

  public var profile_id: Int

  public init(profile_id: Int) {
    self.profile_id = profile_id
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("app_trading_money_flow", arguments: ["where": ["status": ["_eq": "PENDING"], "profile_id": ["_eq": GraphQLVariable("profile_id")]]], type: .nonNull(.list(.nonNull(.object(AppTradingMoneyFlow.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appTradingMoneyFlow: [AppTradingMoneyFlow]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_trading_money_flow": appTradingMoneyFlow.map { (value: AppTradingMoneyFlow) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.trading_money_flow"
    public var appTradingMoneyFlow: [AppTradingMoneyFlow] {
      get {
        return (resultMap["app_trading_money_flow"] as! [ResultMap]).map { (value: ResultMap) -> AppTradingMoneyFlow in AppTradingMoneyFlow(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppTradingMoneyFlow) -> ResultMap in value.resultMap }, forKey: "app_trading_money_flow")
      }
    }

    public struct AppTradingMoneyFlow: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_trading_money_flow"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("amount", type: .nonNull(.scalar(numeric.self))),
          GraphQLField("created_at", type: .nonNull(.scalar(timestamptz.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(amount: numeric, createdAt: timestamptz) {
        self.init(unsafeResultMap: ["__typename": "app_trading_money_flow", "amount": amount, "created_at": createdAt])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var amount: numeric {
        get {
          return resultMap["amount"]! as! numeric
        }
        set {
          resultMap.updateValue(newValue, forKey: "amount")
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
    }
  }
}
