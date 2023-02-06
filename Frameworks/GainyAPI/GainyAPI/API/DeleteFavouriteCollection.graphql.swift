// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class DeleteProfileFavoriteCollectionMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DeleteProfileFavoriteCollection($profileID: Int!, $collectionID: Int!) {
      delete_app_profile_favorite_collections(
        where: {collection_id: {_eq: $collectionID}, profile_id: {_eq: $profileID}}
      ) {
        __typename
        returning {
          __typename
          collection_id
        }
      }
    }
    """

  public let operationName: String = "DeleteProfileFavoriteCollection"

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
        GraphQLField("delete_app_profile_favorite_collections", arguments: ["where": ["collection_id": ["_eq": GraphQLVariable("collectionID")], "profile_id": ["_eq": GraphQLVariable("profileID")]]], type: .object(DeleteAppProfileFavoriteCollection.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteAppProfileFavoriteCollections: DeleteAppProfileFavoriteCollection? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "delete_app_profile_favorite_collections": deleteAppProfileFavoriteCollections.flatMap { (value: DeleteAppProfileFavoriteCollection) -> ResultMap in value.resultMap }])
    }

    /// delete data from the table: "app.profile_favorite_collections"
    public var deleteAppProfileFavoriteCollections: DeleteAppProfileFavoriteCollection? {
      get {
        return (resultMap["delete_app_profile_favorite_collections"] as? ResultMap).flatMap { DeleteAppProfileFavoriteCollection(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "delete_app_profile_favorite_collections")
      }
    }

    public struct DeleteAppProfileFavoriteCollection: GraphQLSelectionSet {
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
