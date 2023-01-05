// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ViewNotificationsMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation ViewNotifications($notifications: [app_profile_notification_viewed_insert_input!]!) {
      insert_app_profile_notification_viewed(
        objects: $notifications
        on_conflict: {constraint: profile_notification_viewed_pkey}
      ) {
        __typename
        affected_rows
      }
    }
    """

  public let operationName: String = "ViewNotifications"

  public var notifications: [app_profile_notification_viewed_insert_input]

  public init(notifications: [app_profile_notification_viewed_insert_input]) {
    self.notifications = notifications
  }

  public var variables: GraphQLMap? {
    return ["notifications": notifications]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_app_profile_notification_viewed", arguments: ["objects": GraphQLVariable("notifications"), "on_conflict": ["constraint": "profile_notification_viewed_pkey"]], type: .object(InsertAppProfileNotificationViewed.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertAppProfileNotificationViewed: InsertAppProfileNotificationViewed? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_app_profile_notification_viewed": insertAppProfileNotificationViewed.flatMap { (value: InsertAppProfileNotificationViewed) -> ResultMap in value.resultMap }])
    }

    /// insert data into the table: "app.profile_notification_viewed"
    public var insertAppProfileNotificationViewed: InsertAppProfileNotificationViewed? {
      get {
        return (resultMap["insert_app_profile_notification_viewed"] as? ResultMap).flatMap { InsertAppProfileNotificationViewed(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_app_profile_notification_viewed")
      }
    }

    public struct InsertAppProfileNotificationViewed: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profile_notification_viewed_mutation_response"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("affected_rows", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(affectedRows: Int) {
        self.init(unsafeResultMap: ["__typename": "app_profile_notification_viewed_mutation_response", "affected_rows": affectedRows])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// number of rows affected by the mutation
      public var affectedRows: Int {
        get {
          return resultMap["affected_rows"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "affected_rows")
        }
      }
    }
  }
}
