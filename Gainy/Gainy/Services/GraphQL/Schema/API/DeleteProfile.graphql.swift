// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class DeleteProfileMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DeleteProfile($profileID: Int!) {
      delete_app_profiles_by_pk(id: $profileID) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "DeleteProfile"

  public var profileID: Int

  public init(profileID: Int) {
    self.profileID = profileID
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("delete_app_profiles_by_pk", arguments: ["id": GraphQLVariable("profileID")], type: .object(DeleteAppProfilesByPk.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteAppProfilesByPk: DeleteAppProfilesByPk? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "delete_app_profiles_by_pk": deleteAppProfilesByPk.flatMap { (value: DeleteAppProfilesByPk) -> ResultMap in value.resultMap }])
    }

    /// delete single row from the table: "app.profiles"
    public var deleteAppProfilesByPk: DeleteAppProfilesByPk? {
      get {
        return (resultMap["delete_app_profiles_by_pk"] as? ResultMap).flatMap { DeleteAppProfilesByPk(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "delete_app_profiles_by_pk")
      }
    }

    public struct DeleteAppProfilesByPk: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profiles"]

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
        self.init(unsafeResultMap: ["__typename": "app_profiles", "id": id])
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
