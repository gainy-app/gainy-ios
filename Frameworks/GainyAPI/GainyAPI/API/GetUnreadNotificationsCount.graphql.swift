// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetUnreadNotificationsCountQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetUnreadNotificationsCount($profileId: Int!) {
      profile_flags(where: {profile_id: {_eq: $profileId}}) {
        __typename
        not_viewed_notifications_count
      }
    }
    """

  public let operationName: String = "GetUnreadNotificationsCount"

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
        GraphQLField("profile_flags", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileId")]]], type: .nonNull(.list(.nonNull(.object(ProfileFlag.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(profileFlags: [ProfileFlag]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "profile_flags": profileFlags.map { (value: ProfileFlag) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230609084853.profile_flags"
    public var profileFlags: [ProfileFlag] {
      get {
        return (resultMap["profile_flags"] as! [ResultMap]).map { (value: ResultMap) -> ProfileFlag in ProfileFlag(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: ProfileFlag) -> ResultMap in value.resultMap }, forKey: "profile_flags")
      }
    }

    public struct ProfileFlag: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["profile_flags"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("not_viewed_notifications_count", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(notViewedNotificationsCount: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "profile_flags", "not_viewed_notifications_count": notViewedNotificationsCount])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var notViewedNotificationsCount: Int? {
        get {
          return resultMap["not_viewed_notifications_count"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "not_viewed_notifications_count")
        }
      }
    }
  }
}
