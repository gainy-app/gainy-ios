// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class InsertProfileCategoryMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation InsertProfileCategory($profileID: Int!, $categoryID: Int!) {
      insert_app_profile_categories(
        objects: {category_id: $categoryID, profile_id: $profileID}
      ) {
        __typename
        returning {
          __typename
          category_id
        }
      }
    }
    """

  public let operationName: String = "InsertProfileCategory"

  public var profileID: Int
  public var categoryID: Int

  public init(profileID: Int, categoryID: Int) {
    self.profileID = profileID
    self.categoryID = categoryID
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID, "categoryID": categoryID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_app_profile_categories", arguments: ["objects": ["category_id": GraphQLVariable("categoryID"), "profile_id": GraphQLVariable("profileID")]], type: .object(InsertAppProfileCategory.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertAppProfileCategories: InsertAppProfileCategory? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_app_profile_categories": insertAppProfileCategories.flatMap { (value: InsertAppProfileCategory) -> ResultMap in value.resultMap }])
    }

    /// insert data into the table: "app.profile_categories"
    public var insertAppProfileCategories: InsertAppProfileCategory? {
      get {
        return (resultMap["insert_app_profile_categories"] as? ResultMap).flatMap { InsertAppProfileCategory(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_app_profile_categories")
      }
    }

    public struct InsertAppProfileCategory: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profile_categories_mutation_response"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("returning", type: .nonNull(.list(.nonNull(.object(Returning.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(returning: [Returning]) {
        self.init(unsafeResultMap: ["__typename": "app_profile_categories_mutation_response", "returning": returning.map { (value: Returning) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// data from the rows affected by the mutation
      public var returning: [Returning] {
        get {
          return (resultMap["returning"] as! [ResultMap]).map { (value: ResultMap) -> Returning in Returning(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Returning) -> ResultMap in value.resultMap }, forKey: "returning")
        }
      }

      public struct Returning: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_profile_categories"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("category_id", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(categoryId: Int) {
          self.init(unsafeResultMap: ["__typename": "app_profile_categories", "category_id": categoryId])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var categoryId: Int {
          get {
            return resultMap["category_id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "category_id")
          }
        }
      }
    }
  }
}
