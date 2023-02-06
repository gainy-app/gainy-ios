// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class InsertProfileFavoriteCollectionMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation InsertProfileFavoriteCollection($profileID: Int!, $collectionID: Int!) {
      insert_app_profile_favorite_collections(
        objects: {collection_id: $collectionID, profile_id: $profileID}
      ) {
        __typename
        returning {
          __typename
          collection_id
        }
      }
    }
    """

  public let operationName: String = "InsertProfileFavoriteCollection"

  public var profileID: Int
  public var collectionID: Int

  public init(profileID: Int, collectionID: Int) {
    self.profileID = profileID
    self.collectionID = collectionID
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID, "collectionID": collectionID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_app_profile_favorite_collections", arguments: ["objects": ["collection_id": GraphQLVariable("collectionID"), "profile_id": GraphQLVariable("profileID")]], type: .object(InsertAppProfileFavoriteCollection.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertAppProfileFavoriteCollections: InsertAppProfileFavoriteCollection? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_app_profile_favorite_collections": insertAppProfileFavoriteCollections.flatMap { (value: InsertAppProfileFavoriteCollection) -> ResultMap in value.resultMap }])
    }

    /// insert data into the table: "app.profile_favorite_collections"
    public var insertAppProfileFavoriteCollections: InsertAppProfileFavoriteCollection? {
      get {
        return (resultMap["insert_app_profile_favorite_collections"] as? ResultMap).flatMap { InsertAppProfileFavoriteCollection(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_app_profile_favorite_collections")
      }
    }

    public struct InsertAppProfileFavoriteCollection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profile_favorite_collections_mutation_response"]

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
        self.init(unsafeResultMap: ["__typename": "app_profile_favorite_collections_mutation_response", "returning": returning.map { (value: Returning) -> ResultMap in value.resultMap }])
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
        public static let possibleTypes: [String] = ["app_profile_favorite_collections"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("collection_id", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(collectionId: Int) {
          self.init(unsafeResultMap: ["__typename": "app_profile_favorite_collections", "collection_id": collectionId])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var collectionId: Int {
          get {
            return resultMap["collection_id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "collection_id")
          }
        }
      }
    }
  }
}
