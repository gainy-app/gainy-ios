// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetSelectedInterestsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetSelectedInterests($ids: [Int!]) {
      interests(where: {enabled: {_eq: "1"}, id: {_in: $ids}}) {
        __typename
        icon_url
        id
        name
      }
    }
    """

  public let operationName: String = "GetSelectedInterests"

  public var ids: [Int]?

  public init(ids: [Int]?) {
    self.ids = ids
  }

  public var variables: GraphQLMap? {
    return ["ids": ids]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("interests", arguments: ["where": ["enabled": ["_eq": "1"], "id": ["_in": GraphQLVariable("ids")]]], type: .nonNull(.list(.nonNull(.object(Interest.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(interests: [Interest]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "interests": interests.map { (value: Interest) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_220310130320.interests"
    public var interests: [Interest] {
      get {
        return (resultMap["interests"] as! [ResultMap]).map { (value: ResultMap) -> Interest in Interest(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Interest) -> ResultMap in value.resultMap }, forKey: "interests")
      }
    }

    public struct Interest: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["interests"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("icon_url", type: .scalar(String.self)),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("name", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(iconUrl: String? = nil, id: Int? = nil, name: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "interests", "icon_url": iconUrl, "id": id, "name": name])
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

      public var id: Int? {
        get {
          return resultMap["id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
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
    }
  }
}
