// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingGetProfileStatusQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query TradingGetProfileStatus($profile_id: Int!) {
      trading_profile_status(where: {profile_id: {_eq: $profile_id}}) {
        __typename
        buying_power
        deposited_funds
        funding_account_connected
        kyc_done
        withdrawable_cash
      }
      app_trading_money_flow(where: {status: {_eq: "PENDING"}}) {
        __typename
        amount
        created_at
      }
    }
    """

  public let operationName: String = "TradingGetProfileStatus"

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
        GraphQLField("trading_profile_status", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profile_id")]]], type: .nonNull(.list(.nonNull(.object(TradingProfileStatus.selections))))),
        GraphQLField("app_trading_money_flow", arguments: ["where": ["status": ["_eq": "PENDING"]]], type: .nonNull(.list(.nonNull(.object(AppTradingMoneyFlow.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingProfileStatus: [TradingProfileStatus], appTradingMoneyFlow: [AppTradingMoneyFlow]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "trading_profile_status": tradingProfileStatus.map { (value: TradingProfileStatus) -> ResultMap in value.resultMap }, "app_trading_money_flow": appTradingMoneyFlow.map { (value: AppTradingMoneyFlow) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_221110054425.trading_profile_status"
    public var tradingProfileStatus: [TradingProfileStatus] {
      get {
        return (resultMap["trading_profile_status"] as! [ResultMap]).map { (value: ResultMap) -> TradingProfileStatus in TradingProfileStatus(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: TradingProfileStatus) -> ResultMap in value.resultMap }, forKey: "trading_profile_status")
      }
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

    public struct TradingProfileStatus: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["trading_profile_status"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("buying_power", type: .scalar(float8.self)),
          GraphQLField("deposited_funds", type: .scalar(Bool.self)),
          GraphQLField("funding_account_connected", type: .scalar(Bool.self)),
          GraphQLField("kyc_done", type: .scalar(Bool.self)),
          GraphQLField("withdrawable_cash", type: .scalar(float8.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(buyingPower: float8? = nil, depositedFunds: Bool? = nil, fundingAccountConnected: Bool? = nil, kycDone: Bool? = nil, withdrawableCash: float8? = nil) {
        self.init(unsafeResultMap: ["__typename": "trading_profile_status", "buying_power": buyingPower, "deposited_funds": depositedFunds, "funding_account_connected": fundingAccountConnected, "kyc_done": kycDone, "withdrawable_cash": withdrawableCash])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var buyingPower: float8? {
        get {
          return resultMap["buying_power"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "buying_power")
        }
      }

      public var depositedFunds: Bool? {
        get {
          return resultMap["deposited_funds"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "deposited_funds")
        }
      }

      public var fundingAccountConnected: Bool? {
        get {
          return resultMap["funding_account_connected"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "funding_account_connected")
        }
      }

      public var kycDone: Bool? {
        get {
          return resultMap["kyc_done"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "kyc_done")
        }
      }

      public var withdrawableCash: float8? {
        get {
          return resultMap["withdrawable_cash"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "withdrawable_cash")
        }
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
