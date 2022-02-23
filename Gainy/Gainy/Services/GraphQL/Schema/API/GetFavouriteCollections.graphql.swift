// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetFavoriteCollectionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetFavoriteCollections($profileId: Int) {
      app_profile_favorite_collections(where: {profile_id: {_eq: $profileId}}) {
        __typename
        collection {
          __typename
          ...RemoteShortCollectionDetails
        }
      }
    }
    """

  public let operationName: String = "GetFavoriteCollections"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RemoteShortCollectionDetails.fragmentDefinition)
    return document
  }

  public var profileId: Int?

  public init(profileId: Int? = nil) {
    self.profileId = profileId
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("app_profile_favorite_collections", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileId")]]], type: .nonNull(.list(.nonNull(.object(AppProfileFavoriteCollection.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appProfileFavoriteCollections: [AppProfileFavoriteCollection]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_profile_favorite_collections": appProfileFavoriteCollections.map { (value: AppProfileFavoriteCollection) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.profile_favorite_collections"
    public var appProfileFavoriteCollections: [AppProfileFavoriteCollection] {
      get {
        return (resultMap["app_profile_favorite_collections"] as! [ResultMap]).map { (value: ResultMap) -> AppProfileFavoriteCollection in AppProfileFavoriteCollection(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppProfileFavoriteCollection) -> ResultMap in value.resultMap }, forKey: "app_profile_favorite_collections")
      }
    }

    public struct AppProfileFavoriteCollection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profile_favorite_collections"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("collection", type: .object(Collection.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(collection: Collection? = nil) {
        self.init(unsafeResultMap: ["__typename": "app_profile_favorite_collections", "collection": collection.flatMap { (value: Collection) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// An object relationship
      public var collection: Collection? {
        get {
          return (resultMap["collection"] as? ResultMap).flatMap { Collection(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "collection")
        }
      }

      public struct Collection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["collections"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RemoteShortCollectionDetails.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var remoteShortCollectionDetails: RemoteShortCollectionDetails {
            get {
              return RemoteShortCollectionDetails(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}
