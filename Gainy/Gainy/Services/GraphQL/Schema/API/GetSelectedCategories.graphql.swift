// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetSelectedCategoriesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetSelectedCategories($ids: [Int!]) {
      categories(where: {id: {_in: $ids}}) {
        __typename
        icon_url
        id
        name
      }
    }
    """

  public let operationName: String = "GetSelectedCategories"

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
        GraphQLField("categories", arguments: ["where": ["id": ["_in": GraphQLVariable("ids")]]], type: .nonNull(.list(.nonNull(.object(Category.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(categories: [Category]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "categories": categories.map { (value: Category) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_220503062333.categories"
    public var categories: [Category] {
      get {
        return (resultMap["categories"] as! [ResultMap]).map { (value: ResultMap) -> Category in Category(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Category) -> ResultMap in value.resultMap }, forKey: "categories")
      }
    }

    public struct Category: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["categories"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("icon_url", type: .scalar(String.self)),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(iconUrl: String? = nil, id: Int, name: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "categories", "icon_url": iconUrl, "id": id, "name": name])
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
