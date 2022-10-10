// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingLinkBankAccountWithPlaidMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation TradingLinkBankAccountWithPlaid($profile_id: Int!, $account_id: String!, $account_name: String!, $access_token_id: Int!) {
      trading_link_bank_account_with_plaid(
        profile_id: $profile_id
        account_id: $account_id
        account_name: $account_name
        access_token_id: $access_token_id
      ) {
        __typename
        funding_account {
          __typename
          id
          balance
          name
        }
      }
    }
    """

  public let operationName: String = "TradingLinkBankAccountWithPlaid"

  public var profile_id: Int
  public var account_id: String
  public var account_name: String
  public var access_token_id: Int

  public init(profile_id: Int, account_id: String, account_name: String, access_token_id: Int) {
    self.profile_id = profile_id
    self.account_id = account_id
    self.account_name = account_name
    self.access_token_id = access_token_id
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "account_id": account_id, "account_name": account_name, "access_token_id": access_token_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("trading_link_bank_account_with_plaid", arguments: ["profile_id": GraphQLVariable("profile_id"), "account_id": GraphQLVariable("account_id"), "account_name": GraphQLVariable("account_name"), "access_token_id": GraphQLVariable("access_token_id")], type: .object(TradingLinkBankAccountWithPlaid.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingLinkBankAccountWithPlaid: TradingLinkBankAccountWithPlaid? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "trading_link_bank_account_with_plaid": tradingLinkBankAccountWithPlaid.flatMap { (value: TradingLinkBankAccountWithPlaid) -> ResultMap in value.resultMap }])
    }

    public var tradingLinkBankAccountWithPlaid: TradingLinkBankAccountWithPlaid? {
      get {
        return (resultMap["trading_link_bank_account_with_plaid"] as? ResultMap).flatMap { TradingLinkBankAccountWithPlaid(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "trading_link_bank_account_with_plaid")
      }
    }

    public struct TradingLinkBankAccountWithPlaid: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["TradingLinkBankAccountWithPlaidOutput"]

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
        self.init(unsafeResultMap: ["__typename": "TradingLinkBankAccountWithPlaidOutput", "funding_account": fundingAccount.flatMap { (value: FundingAccount) -> ResultMap in value.resultMap }])
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
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, balance: float8? = nil, name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "app_trading_funding_accounts", "id": id, "balance": balance, "name": name])
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
      }
    }
  }
}
