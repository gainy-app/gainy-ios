// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class AppInterestsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query AppInterests {
      app_interests {
        __typename
        icon_url
        id
        name
      }
    }
    """

  public let operationName: String = "AppInterests"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("app_interests", type: .nonNull(.list(.nonNull(.object(AppInterest.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appInterests: [AppInterest]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_interests": appInterests.map { (value: AppInterest) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.interests"
    public var appInterests: [AppInterest] {
      get {
        return (resultMap["app_interests"] as! [ResultMap]).map { (value: ResultMap) -> AppInterest in AppInterest(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppInterest) -> ResultMap in value.resultMap }, forKey: "app_interests")
      }
    }

    public struct AppInterest: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_interests"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("icon_url", type: .scalar(String.self)),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(iconUrl: String? = nil, id: Int, name: String) {
        self.init(unsafeResultMap: ["__typename": "app_interests", "icon_url": iconUrl, "id": id, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var iconUrl: String? {
        get {
          return resultMap["icon_url"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "icon_url")
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

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }
  }
}
