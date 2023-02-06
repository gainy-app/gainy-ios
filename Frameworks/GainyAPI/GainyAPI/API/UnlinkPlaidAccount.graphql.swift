// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class UnlinkPlaidAccountMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UnlinkPlaidAccount($publicTokenID: Int!) {
      delete_app_profile_plaid_access_tokens_by_pk(id: $publicTokenID) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "UnlinkPlaidAccount"

  public var publicTokenID: Int

  public init(publicTokenID: Int) {
    self.publicTokenID = publicTokenID
  }

  public var variables: GraphQLMap? {
    return ["publicTokenID": publicTokenID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("delete_app_profile_plaid_access_tokens_by_pk", arguments: ["id": GraphQLVariable("publicTokenID")], type: .object(DeleteAppProfilePlaidAccessTokensByPk.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteAppProfilePlaidAccessTokensByPk: DeleteAppProfilePlaidAccessTokensByPk? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "delete_app_profile_plaid_access_tokens_by_pk": deleteAppProfilePlaidAccessTokensByPk.flatMap { (value: DeleteAppProfilePlaidAccessTokensByPk) -> ResultMap in value.resultMap }])
    }

    /// delete single row from the table: "app.profile_plaid_access_tokens"
    public var deleteAppProfilePlaidAccessTokensByPk: DeleteAppProfilePlaidAccessTokensByPk? {
      get {
        return (resultMap["delete_app_profile_plaid_access_tokens_by_pk"] as? ResultMap).flatMap { DeleteAppProfilePlaidAccessTokensByPk(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "delete_app_profile_plaid_access_tokens_by_pk")
      }
    }

    public struct DeleteAppProfilePlaidAccessTokensByPk: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profile_plaid_access_tokens"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int) {
        self.init(unsafeResultMap: ["__typename": "app_profile_plaid_access_tokens", "id": id])
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
    }
  }
}
