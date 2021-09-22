// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class AppProfilesUserIDsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query AppProfilesUserIDs {
      app_profiles {
        __typename
        user_id
      }
    }
    """

  public let operationName: String = "AppProfilesUserIDs"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("app_profiles", type: .nonNull(.list(.nonNull(.object(AppProfile.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appProfiles: [AppProfile]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_profiles": appProfiles.map { (value: AppProfile) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.profiles"
    public var appProfiles: [AppProfile] {
      get {
        return (resultMap["app_profiles"] as! [ResultMap]).map { (value: ResultMap) -> AppProfile in AppProfile(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppProfile) -> ResultMap in value.resultMap }, forKey: "app_profiles")
      }
    }

    public struct AppProfile: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profiles"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("user_id", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(userId: String) {
        self.init(unsafeResultMap: ["__typename": "app_profiles", "user_id": userId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var userId: String {
        get {
          return resultMap["user_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "user_id")
        }
      }
    }
  }
}
