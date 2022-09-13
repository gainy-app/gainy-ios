// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class CreatePlaidLinkQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query CreatePlaidLink($profileId: Int!, $redirectUri: String!, $env: String!) {
      create_plaid_link_token(
        profile_id: $profileId
        redirect_uri: $redirectUri
        env: $env
      ) {
        __typename
        link_token
      }
    }
    """

  public let operationName: String = "CreatePlaidLink"

  public var profileId: Int
  public var redirectUri: String
  public var env: String

  public init(profileId: Int, redirectUri: String, env: String) {
    self.profileId = profileId
    self.redirectUri = redirectUri
    self.env = env
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "redirectUri": redirectUri, "env": env]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("create_plaid_link_token", arguments: ["profile_id": GraphQLVariable("profileId"), "redirect_uri": GraphQLVariable("redirectUri"), "env": GraphQLVariable("env")], type: .object(CreatePlaidLinkToken.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createPlaidLinkToken: CreatePlaidLinkToken? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "create_plaid_link_token": createPlaidLinkToken.flatMap { (value: CreatePlaidLinkToken) -> ResultMap in value.resultMap }])
    }

    public var createPlaidLinkToken: CreatePlaidLinkToken? {
      get {
        return (resultMap["create_plaid_link_token"] as? ResultMap).flatMap { CreatePlaidLinkToken(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "create_plaid_link_token")
      }
    }

    public struct CreatePlaidLinkToken: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["CreatePlaidLinkTokenOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("link_token", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(linkToken: String) {
        self.init(unsafeResultMap: ["__typename": "CreatePlaidLinkTokenOutput", "link_token": linkToken])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var linkToken: String {
        get {
          return resultMap["link_token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "link_token")
        }
      }
    }
  }
}

public final class ReCreatePlaidLinkQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ReCreatePlaidLink($profileId: Int!, $accessTokenId: Int!, $redirectUri: String!, $env: String!) {
      create_plaid_link_token(
        access_token_id: $accessTokenId
        profile_id: $profileId
        redirect_uri: $redirectUri
        env: $env
      ) {
        __typename
        link_token
      }
    }
    """

  public let operationName: String = "ReCreatePlaidLink"

  public var profileId: Int
  public var accessTokenId: Int
  public var redirectUri: String
  public var env: String

  public init(profileId: Int, accessTokenId: Int, redirectUri: String, env: String) {
    self.profileId = profileId
    self.accessTokenId = accessTokenId
    self.redirectUri = redirectUri
    self.env = env
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "accessTokenId": accessTokenId, "redirectUri": redirectUri, "env": env]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("create_plaid_link_token", arguments: ["access_token_id": GraphQLVariable("accessTokenId"), "profile_id": GraphQLVariable("profileId"), "redirect_uri": GraphQLVariable("redirectUri"), "env": GraphQLVariable("env")], type: .object(CreatePlaidLinkToken.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createPlaidLinkToken: CreatePlaidLinkToken? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "create_plaid_link_token": createPlaidLinkToken.flatMap { (value: CreatePlaidLinkToken) -> ResultMap in value.resultMap }])
    }

    public var createPlaidLinkToken: CreatePlaidLinkToken? {
      get {
        return (resultMap["create_plaid_link_token"] as? ResultMap).flatMap { CreatePlaidLinkToken(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "create_plaid_link_token")
      }
    }

    public struct CreatePlaidLinkToken: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["CreatePlaidLinkTokenOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("link_token", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(linkToken: String) {
        self.init(unsafeResultMap: ["__typename": "CreatePlaidLinkTokenOutput", "link_token": linkToken])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var linkToken: String {
        get {
          return resultMap["link_token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "link_token")
        }
      }
    }
  }
}
