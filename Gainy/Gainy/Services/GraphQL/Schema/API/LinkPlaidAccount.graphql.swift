// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class LinkPlaidAccountQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query LinkPlaidAccount($profileId: Int!, $publicToken: String!) {
      link_plaid_account(profile_id: $profileId, public_token: $publicToken) {
        __typename
        result
        plaid_access_token_id
      }
    }
    """

  public let operationName: String = "LinkPlaidAccount"

  public var profileId: Int
  public var publicToken: String

  public init(profileId: Int, publicToken: String) {
    self.profileId = profileId
    self.publicToken = publicToken
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "publicToken": publicToken]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("link_plaid_account", arguments: ["profile_id": GraphQLVariable("profileId"), "public_token": GraphQLVariable("publicToken")], type: .object(LinkPlaidAccount.selections)),
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
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: Bool, plaidAccessTokenId: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "LinkPlaidAccountOutput", "result": result, "plaid_access_token_id": plaidAccessTokenId])
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
    }
  }
}
