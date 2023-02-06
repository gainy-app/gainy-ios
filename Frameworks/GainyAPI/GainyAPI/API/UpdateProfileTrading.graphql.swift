// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class UpdateProfileTradingMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateProfileTrading($profile_id: Int!, $is_trading_enabled: Boolean) {
      insert_app_profile_flags_one(
        object: {profile_id: $profile_id, is_trading_enabled: $is_trading_enabled}
        on_conflict: {constraint: profile_flags_pkey, update_columns: is_trading_enabled}
      ) {
        __typename
        profile_id
      }
    }
    """

  public let operationName: String = "UpdateProfileTrading"

  public var profile_id: Int
  public var is_trading_enabled: Bool?

  public init(profile_id: Int, is_trading_enabled: Bool? = nil) {
    self.profile_id = profile_id
    self.is_trading_enabled = is_trading_enabled
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "is_trading_enabled": is_trading_enabled]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_app_profile_flags_one", arguments: ["object": ["profile_id": GraphQLVariable("profile_id"), "is_trading_enabled": GraphQLVariable("is_trading_enabled")], "on_conflict": ["constraint": "profile_flags_pkey", "update_columns": "is_trading_enabled"]], type: .object(InsertAppProfileFlagsOne.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertAppProfileFlagsOne: InsertAppProfileFlagsOne? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_app_profile_flags_one": insertAppProfileFlagsOne.flatMap { (value: InsertAppProfileFlagsOne) -> ResultMap in value.resultMap }])
    }

    /// insert a single row into the table: "app.profile_flags"
    public var insertAppProfileFlagsOne: InsertAppProfileFlagsOne? {
      get {
        return (resultMap["insert_app_profile_flags_one"] as? ResultMap).flatMap { InsertAppProfileFlagsOne(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_app_profile_flags_one")
      }
    }

    public struct InsertAppProfileFlagsOne: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profile_flags"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("profile_id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(profileId: Int) {
        self.init(unsafeResultMap: ["__typename": "app_profile_flags", "profile_id": profileId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var profileId: Int {
        get {
          return resultMap["profile_id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "profile_id")
        }
      }
    }
  }
}
