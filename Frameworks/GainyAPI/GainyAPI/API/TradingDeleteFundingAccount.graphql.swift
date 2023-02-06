// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingDeleteFundingAccountMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation TradingDeleteFundingAccount($profile_id: Int!, $funding_account_id: Int!) {
      trading_delete_funding_account(
        profile_id: $profile_id
        funding_account_id: $funding_account_id
      ) {
        __typename
        ok
      }
    }
    """

  public let operationName: String = "TradingDeleteFundingAccount"

  public var profile_id: Int
  public var funding_account_id: Int

  public init(profile_id: Int, funding_account_id: Int) {
    self.profile_id = profile_id
    self.funding_account_id = funding_account_id
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "funding_account_id": funding_account_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("trading_delete_funding_account", arguments: ["profile_id": GraphQLVariable("profile_id"), "funding_account_id": GraphQLVariable("funding_account_id")], type: .object(TradingDeleteFundingAccount.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingDeleteFundingAccount: TradingDeleteFundingAccount? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "trading_delete_funding_account": tradingDeleteFundingAccount.flatMap { (value: TradingDeleteFundingAccount) -> ResultMap in value.resultMap }])
    }

    public var tradingDeleteFundingAccount: TradingDeleteFundingAccount? {
      get {
        return (resultMap["trading_delete_funding_account"] as? ResultMap).flatMap { TradingDeleteFundingAccount(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "trading_delete_funding_account")
      }
    }

    public struct TradingDeleteFundingAccount: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["OkOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ok", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(ok: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "OkOutput", "ok": ok])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var ok: Bool? {
        get {
          return resultMap["ok"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "ok")
        }
      }
    }
  }
}
