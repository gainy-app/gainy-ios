// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingWithdrawFundsMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation TradingWithdrawFunds($profile_id: Int!, $trading_account_id: Int!, $amount: Float!, $funding_account_id: Int!) {
      trading_withdraw_funds(
        profile_id: $profile_id
        trading_account_id: $trading_account_id
        amount: $amount
        funding_account_id: $funding_account_id
      ) {
        __typename
        trading_money_flow_id
      }
    }
    """

  public let operationName: String = "TradingWithdrawFunds"

  public var profile_id: Int
  public var trading_account_id: Int
  public var amount: Double
  public var funding_account_id: Int

  public init(profile_id: Int, trading_account_id: Int, amount: Double, funding_account_id: Int) {
    self.profile_id = profile_id
    self.trading_account_id = trading_account_id
    self.amount = amount
    self.funding_account_id = funding_account_id
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "trading_account_id": trading_account_id, "amount": amount, "funding_account_id": funding_account_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("trading_withdraw_funds", arguments: ["profile_id": GraphQLVariable("profile_id"), "trading_account_id": GraphQLVariable("trading_account_id"), "amount": GraphQLVariable("amount"), "funding_account_id": GraphQLVariable("funding_account_id")], type: .object(TradingWithdrawFund.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingWithdrawFunds: TradingWithdrawFund? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "trading_withdraw_funds": tradingWithdrawFunds.flatMap { (value: TradingWithdrawFund) -> ResultMap in value.resultMap }])
    }

    public var tradingWithdrawFunds: TradingWithdrawFund? {
      get {
        return (resultMap["trading_withdraw_funds"] as? ResultMap).flatMap { TradingWithdrawFund(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "trading_withdraw_funds")
      }
    }

    public struct TradingWithdrawFund: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["TradingMoneyFlowOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("trading_money_flow_id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(tradingMoneyFlowId: Int) {
        self.init(unsafeResultMap: ["__typename": "TradingMoneyFlowOutput", "trading_money_flow_id": tradingMoneyFlowId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var tradingMoneyFlowId: Int {
        get {
          return resultMap["trading_money_flow_id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "trading_money_flow_id")
        }
      }
    }
  }
}
