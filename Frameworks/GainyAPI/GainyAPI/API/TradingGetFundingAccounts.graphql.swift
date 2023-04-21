// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingGetFundingAccountsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query TradingGetFundingAccounts($profile_id: Int!) {
      app_trading_funding_accounts(where: {profile_id: {_eq: $profile_id}}) {
        __typename
        id
        balance
        name
        needs_reauth
      }
    }
    """

  public let operationName: String = "TradingGetFundingAccounts"

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
        GraphQLField("app_trading_funding_accounts", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profile_id")]]], type: .nonNull(.list(.nonNull(.object(AppTradingFundingAccount.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appTradingFundingAccounts: [AppTradingFundingAccount]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_trading_funding_accounts": appTradingFundingAccounts.map { (value: AppTradingFundingAccount) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.trading_funding_accounts"
    public var appTradingFundingAccounts: [AppTradingFundingAccount] {
      get {
        return (resultMap["app_trading_funding_accounts"] as! [ResultMap]).map { (value: ResultMap) -> AppTradingFundingAccount in AppTradingFundingAccount(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppTradingFundingAccount) -> ResultMap in value.resultMap }, forKey: "app_trading_funding_accounts")
      }
    }

    public struct AppTradingFundingAccount: GraphQLSelectionSet {
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
