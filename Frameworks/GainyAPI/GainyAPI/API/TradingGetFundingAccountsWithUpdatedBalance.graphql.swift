// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingGetFundingAccountsWithUpdatedBalanceQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query TradingGetFundingAccountsWithUpdatedBalance($profile_id: Int!) {
      trading_get_funding_accounts(profile_id: $profile_id) {
        __typename
        funding_account {
          __typename
          id
          balance
          name
          needs_reauth
        }
      }
    }
    """

  public let operationName: String = "TradingGetFundingAccountsWithUpdatedBalance"

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
        GraphQLField("trading_get_funding_accounts", arguments: ["profile_id": GraphQLVariable("profile_id")], type: .list(.object(TradingGetFundingAccount.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingGetFundingAccounts: [TradingGetFundingAccount?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "trading_get_funding_accounts": tradingGetFundingAccounts.flatMap { (value: [TradingGetFundingAccount?]) -> [ResultMap?] in value.map { (value: TradingGetFundingAccount?) -> ResultMap? in value.flatMap { (value: TradingGetFundingAccount) -> ResultMap in value.resultMap } } }])
    }

    public var tradingGetFundingAccounts: [TradingGetFundingAccount?]? {
      get {
        return (resultMap["trading_get_funding_accounts"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [TradingGetFundingAccount?] in value.map { (value: ResultMap?) -> TradingGetFundingAccount? in value.flatMap { (value: ResultMap) -> TradingGetFundingAccount in TradingGetFundingAccount(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [TradingGetFundingAccount?]) -> [ResultMap?] in value.map { (value: TradingGetFundingAccount?) -> ResultMap? in value.flatMap { (value: TradingGetFundingAccount) -> ResultMap in value.resultMap } } }, forKey: "trading_get_funding_accounts")
      }
    }

    public struct TradingGetFundingAccount: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["FundingAccount"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("funding_account", type: .object(FundingAccount.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(fundingAccount: FundingAccount? = nil) {
        self.init(unsafeResultMap: ["__typename": "FundingAccount", "funding_account": fundingAccount.flatMap { (value: FundingAccount) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fundingAccount: FundingAccount? {
        get {
          return (resultMap["funding_account"] as? ResultMap).flatMap { FundingAccount(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "funding_account")
        }
      }

      public struct FundingAccount: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_trading_funding_accounts"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("balance", type: .scalar(float8.self)),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("needs_reauth", type: .nonNull(.scalar(Bool.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, balance: float8? = nil, name: String? = nil, needsReauth: Bool) {
          self.init(unsafeResultMap: ["__typename": "app_trading_funding_accounts", "id": id, "balance": balance, "name": name, "needs_reauth": needsReauth])
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

        public var balance: float8? {
          get {
            return resultMap["balance"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "balance")
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

        public var needsReauth: Bool {
          get {
            return resultMap["needs_reauth"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "needs_reauth")
          }
        }
      }
    }
  }
}
