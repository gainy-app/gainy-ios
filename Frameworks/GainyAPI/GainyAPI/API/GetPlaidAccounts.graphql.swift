// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPlaidPortoAccountsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPlaidPortoAccounts($profileId: Int!) {
      app_profile_plaid_access_tokens(
        where: {profile_id: {_eq: $profileId}, purpose: {_eq: "portfolio"}}
      ) {
        __typename
        id
        access_token
        institution {
          __typename
          name
          id
        }
      }
    }
    """

  public let operationName: String = "GetPlaidPortoAccounts"

  public var profileId: Int

  public init(profileId: Int) {
    self.profileId = profileId
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("app_profile_plaid_access_tokens", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileId")], "purpose": ["_eq": "portfolio"]]], type: .nonNull(.list(.nonNull(.object(AppProfilePlaidAccessToken.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appProfilePlaidAccessTokens: [AppProfilePlaidAccessToken]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_profile_plaid_access_tokens": appProfilePlaidAccessTokens.map { (value: AppProfilePlaidAccessToken) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.profile_plaid_access_tokens"
    public var appProfilePlaidAccessTokens: [AppProfilePlaidAccessToken] {
      get {
        return (resultMap["app_profile_plaid_access_tokens"] as! [ResultMap]).map { (value: ResultMap) -> AppProfilePlaidAccessToken in AppProfilePlaidAccessToken(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppProfilePlaidAccessToken) -> ResultMap in value.resultMap }, forKey: "app_profile_plaid_access_tokens")
      }
    }

    public struct AppProfilePlaidAccessToken: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profile_plaid_access_tokens"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("access_token", type: .nonNull(.scalar(String.self))),
          GraphQLField("institution", type: .object(Institution.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, accessToken: String, institution: Institution? = nil) {
        self.init(unsafeResultMap: ["__typename": "app_profile_plaid_access_tokens", "id": id, "access_token": accessToken, "institution": institution.flatMap { (value: Institution) -> ResultMap in value.resultMap }])
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

      public var accessToken: String {
        get {
          return resultMap["access_token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "access_token")
        }
      }

      /// An object relationship
      public var institution: Institution? {
        get {
          return (resultMap["institution"] as? ResultMap).flatMap { Institution(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "institution")
        }
      }

      public struct Institution: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_plaid_institutions"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, id: Int) {
          self.init(unsafeResultMap: ["__typename": "app_plaid_institutions", "name": name, "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }
    }
  }
}
