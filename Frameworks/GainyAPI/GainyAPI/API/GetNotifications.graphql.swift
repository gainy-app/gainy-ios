// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetNotificationsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetNotifications($profileId: Int!) {
      notifications(
        where: {profile_id: {_eq: $profileId}}
        order_by: [{created_at: desc}]
      ) {
        __typename
        created_at
        data
        is_viewed
        notification_uuid
        profile_id
        text
        title
      }
    }
    """

  public let operationName: String = "GetNotifications"

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
        GraphQLField("notifications", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileId")]], "order_by": [["created_at": "desc"]]], type: .nonNull(.list(.nonNull(.object(Notification.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(notifications: [Notification]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "notifications": notifications.map { (value: Notification) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230513174732.notifications"
    public var notifications: [Notification] {
      get {
        return (resultMap["notifications"] as! [ResultMap]).map { (value: ResultMap) -> Notification in Notification(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Notification) -> ResultMap in value.resultMap }, forKey: "notifications")
      }
    }

    public struct Notification: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["notifications"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("created_at", type: .scalar(timestamptz.self)),
          GraphQLField("data", type: .scalar(json.self)),
          GraphQLField("is_viewed", type: .scalar(Bool.self)),
          GraphQLField("notification_uuid", type: .scalar(uuid.self)),
          GraphQLField("profile_id", type: .scalar(Int.self)),
          GraphQLField("text", type: .scalar(json.self)),
          GraphQLField("title", type: .scalar(json.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(createdAt: timestamptz? = nil, data: json? = nil, isViewed: Bool? = nil, notificationUuid: uuid? = nil, profileId: Int? = nil, text: json? = nil, title: json? = nil) {
        self.init(unsafeResultMap: ["__typename": "notifications", "created_at": createdAt, "data": data, "is_viewed": isViewed, "notification_uuid": notificationUuid, "profile_id": profileId, "text": text, "title": title])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var createdAt: timestamptz? {
        get {
          return resultMap["created_at"] as? timestamptz
        }
        set {
          resultMap.updateValue(newValue, forKey: "created_at")
        }
      }

      public var data: json? {
        get {
          return resultMap["data"] as? json
        }
        set {
          resultMap.updateValue(newValue, forKey: "data")
        }
      }

      public var isViewed: Bool? {
        get {
          return resultMap["is_viewed"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "is_viewed")
        }
      }

      public var notificationUuid: uuid? {
        get {
          return resultMap["notification_uuid"] as? uuid
        }
        set {
          resultMap.updateValue(newValue, forKey: "notification_uuid")
        }
      }

      public var profileId: Int? {
        get {
          return resultMap["profile_id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "profile_id")
        }
      }

      public var text: json? {
        get {
          return resultMap["text"] as? json
        }
        set {
          resultMap.updateValue(newValue, forKey: "text")
        }
      }

      public var title: json? {
        get {
          return resultMap["title"] as? json
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }
    }
  }
}
