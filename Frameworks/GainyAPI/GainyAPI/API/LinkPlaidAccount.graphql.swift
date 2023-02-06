// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class LinkPlaidAccountQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query LinkPlaidAccount($profileId: Int!, $publicToken: String!, $env: String!, $access_token_id: Int, $purpose: String) {
      link_plaid_account(
        profile_id: $profileId
        public_token: $publicToken
        env: $env
        access_token_id: $access_token_id
        purpose: $purpose
      ) {
        __typename
        result
        plaid_access_token_id
        institution_name
        accounts {
          __typename
          account_id
          balance_available
          balance_current
          iso_currency_code
          mask
          name
          official_name
        }
      }
    }
    """

  public let operationName: String = "LinkPlaidAccount"

  public var profileId: Int
  public var publicToken: String
  public var env: String
  public var access_token_id: Int?
  public var purpose: String?

  public init(profileId: Int, publicToken: String, env: String, access_token_id: Int? = nil, purpose: String? = nil) {
    self.profileId = profileId
    self.publicToken = publicToken
    self.env = env
    self.access_token_id = access_token_id
    self.purpose = purpose
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "publicToken": publicToken, "env": env, "access_token_id": access_token_id, "purpose": purpose]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("link_plaid_account", arguments: ["profile_id": GraphQLVariable("profileId"), "public_token": GraphQLVariable("publicToken"), "env": GraphQLVariable("env"), "access_token_id": GraphQLVariable("access_token_id"), "purpose": GraphQLVariable("purpose")], type: .object(LinkPlaidAccount.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(linkPlaidAccount: LinkPlaidAccount? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "link_plaid_account": linkPlaidAccount.flatMap { (value: LinkPlaidAccount) -> ResultMap in value.resultMap }])
    }

    public var linkPlaidAccount: LinkPlaidAccount? {
      get {
        return (resultMap["link_plaid_account"] as? ResultMap).flatMap { LinkPlaidAccount(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "link_plaid_account")
      }
    }

    public struct LinkPlaidAccount: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["LinkPlaidAccountOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("result", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("plaid_access_token_id", type: .scalar(Int.self)),
          GraphQLField("institution_name", type: .scalar(String.self)),
          GraphQLField("accounts", type: .list(.object(Account.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: Bool, plaidAccessTokenId: Int? = nil, institutionName: String? = nil, accounts: [Account?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "LinkPlaidAccountOutput", "result": result, "plaid_access_token_id": plaidAccessTokenId, "institution_name": institutionName, "accounts": accounts.flatMap { (value: [Account?]) -> [ResultMap?] in value.map { (value: Account?) -> ResultMap? in value.flatMap { (value: Account) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var result: Bool {
        get {
          return resultMap["result"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "result")
        }
      }

      public var plaidAccessTokenId: Int? {
        get {
          return resultMap["plaid_access_token_id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "plaid_access_token_id")
        }
      }

      public var institutionName: String? {
        get {
          return resultMap["institution_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "institution_name")
        }
      }

      public var accounts: [Account?]? {
        get {
          return (resultMap["accounts"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Account?] in value.map { (value: ResultMap?) -> Account? in value.flatMap { (value: ResultMap) -> Account in Account(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Account?]) -> [ResultMap?] in value.map { (value: Account?) -> ResultMap? in value.flatMap { (value: Account) -> ResultMap in value.resultMap } } }, forKey: "accounts")
        }
      }

      public struct Account: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["AccountInformation"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("account_id", type: .nonNull(.scalar(String.self))),
            GraphQLField("balance_available", type: .nonNull(.scalar(Double.self))),
            GraphQLField("balance_current", type: .nonNull(.scalar(Double.self))),
            GraphQLField("iso_currency_code", type: .nonNull(.scalar(String.self))),
            GraphQLField("mask", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("official_name", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(accountId: String, balanceAvailable: Double, balanceCurrent: Double, isoCurrencyCode: String, mask: String, name: String, officialName: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "AccountInformation", "account_id": accountId, "balance_available": balanceAvailable, "balance_current": balanceCurrent, "iso_currency_code": isoCurrencyCode, "mask": mask, "name": name, "official_name": officialName])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var accountId: String {
          get {
            return resultMap["account_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "account_id")
          }
        }

        public var balanceAvailable: Double {
          get {
            return resultMap["balance_available"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "balance_available")
          }
        }

        public var balanceCurrent: Double {
          get {
            return resultMap["balance_current"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "balance_current")
          }
        }

        public var isoCurrencyCode: String {
          get {
            return resultMap["iso_currency_code"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "iso_currency_code")
          }
        }

        public var mask: String {
          get {
            return resultMap["mask"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "mask")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var officialName: String? {
          get {
            return resultMap["official_name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "official_name")
          }
        }
      }
    }
  }
}

public final class ReLinkPlaidAccountQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ReLinkPlaidAccount($profileId: Int!, $accessTokenId: Int!, $publicToken: String!, $env: String!) {
      link_plaid_account(
        access_token_id: $accessTokenId
        profile_id: $profileId
        public_token: $publicToken
        env: $env
      ) {
        __typename
        result
        plaid_access_token_id
        institution_name
        accounts {
          __typename
          account_id
          balance_available
          balance_current
          iso_currency_code
          mask
          name
          official_name
        }
      }
    }
    """

  public let operationName: String = "ReLinkPlaidAccount"

  public var profileId: Int
  public var accessTokenId: Int
  public var publicToken: String
  public var env: String

  public init(profileId: Int, accessTokenId: Int, publicToken: String, env: String) {
    self.profileId = profileId
    self.accessTokenId = accessTokenId
    self.publicToken = publicToken
    self.env = env
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "accessTokenId": accessTokenId, "publicToken": publicToken, "env": env]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("link_plaid_account", arguments: ["access_token_id": GraphQLVariable("accessTokenId"), "profile_id": GraphQLVariable("profileId"), "public_token": GraphQLVariable("publicToken"), "env": GraphQLVariable("env")], type: .object(LinkPlaidAccount.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(linkPlaidAccount: LinkPlaidAccount? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "link_plaid_account": linkPlaidAccount.flatMap { (value: LinkPlaidAccount) -> ResultMap in value.resultMap }])
    }

    public var linkPlaidAccount: LinkPlaidAccount? {
      get {
        return (resultMap["link_plaid_account"] as? ResultMap).flatMap { LinkPlaidAccount(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "link_plaid_account")
      }
    }

    public struct LinkPlaidAccount: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["LinkPlaidAccountOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("result", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("plaid_access_token_id", type: .scalar(Int.self)),
          GraphQLField("institution_name", type: .scalar(String.self)),
          GraphQLField("accounts", type: .list(.object(Account.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: Bool, plaidAccessTokenId: Int? = nil, institutionName: String? = nil, accounts: [Account?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "LinkPlaidAccountOutput", "result": result, "plaid_access_token_id": plaidAccessTokenId, "institution_name": institutionName, "accounts": accounts.flatMap { (value: [Account?]) -> [ResultMap?] in value.map { (value: Account?) -> ResultMap? in value.flatMap { (value: Account) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var result: Bool {
        get {
          return resultMap["result"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "result")
        }
      }

      public var plaidAccessTokenId: Int? {
        get {
          return resultMap["plaid_access_token_id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "plaid_access_token_id")
        }
      }

      public var institutionName: String? {
        get {
          return resultMap["institution_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "institution_name")
        }
      }

      public var accounts: [Account?]? {
        get {
          return (resultMap["accounts"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Account?] in value.map { (value: ResultMap?) -> Account? in value.flatMap { (value: ResultMap) -> Account in Account(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Account?]) -> [ResultMap?] in value.map { (value: Account?) -> ResultMap? in value.flatMap { (value: Account) -> ResultMap in value.resultMap } } }, forKey: "accounts")
        }
      }

      public struct Account: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["AccountInformation"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("account_id", type: .nonNull(.scalar(String.self))),
            GraphQLField("balance_available", type: .nonNull(.scalar(Double.self))),
            GraphQLField("balance_current", type: .nonNull(.scalar(Double.self))),
            GraphQLField("iso_currency_code", type: .nonNull(.scalar(String.self))),
            GraphQLField("mask", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("official_name", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(accountId: String, balanceAvailable: Double, balanceCurrent: Double, isoCurrencyCode: String, mask: String, name: String, officialName: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "AccountInformation", "account_id": accountId, "balance_available": balanceAvailable, "balance_current": balanceCurrent, "iso_currency_code": isoCurrencyCode, "mask": mask, "name": name, "official_name": officialName])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var accountId: String {
          get {
            return resultMap["account_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "account_id")
          }
        }

        public var balanceAvailable: Double {
          get {
            return resultMap["balance_available"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "balance_available")
          }
        }

        public var balanceCurrent: Double {
          get {
            return resultMap["balance_current"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "balance_current")
          }
        }

        public var isoCurrencyCode: String {
          get {
            return resultMap["iso_currency_code"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "iso_currency_code")
          }
        }

        public var mask: String {
          get {
            return resultMap["mask"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "mask")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var officialName: String? {
          get {
            return resultMap["official_name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "official_name")
          }
        }
      }
    }
  }
}
