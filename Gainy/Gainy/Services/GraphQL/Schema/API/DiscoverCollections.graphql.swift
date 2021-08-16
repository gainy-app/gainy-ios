// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class DiscoverCollectionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query DiscoverCollections {
      app_collections {
        __typename
        name
        image_url
        id
        description
        profile_favorite_collections {
          __typename
          profile_id
          collection_id
        }
        collection_symbols_aggregate {
          __typename
          aggregate {
            __typename
            count
          }
        }
      }
    }
    """

  public let operationName: String = "DiscoverCollections"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("app_collections", type: .nonNull(.list(.nonNull(.object(AppCollection.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appCollections: [AppCollection]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_collections": appCollections.map { (value: AppCollection) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.collections"
    public var appCollections: [AppCollection] {
      get {
        return (resultMap["app_collections"] as! [ResultMap]).map { (value: ResultMap) -> AppCollection in AppCollection(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppCollection) -> ResultMap in value.resultMap }, forKey: "app_collections")
      }
    }

    public struct AppCollection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_collections"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("image_url", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("profile_favorite_collections", type: .nonNull(.list(.nonNull(.object(ProfileFavoriteCollection.selections))))),
          GraphQLField("collection_symbols_aggregate", type: .nonNull(.object(CollectionSymbolsAggregate.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, imageUrl: String, id: Int, description: String? = nil, profileFavoriteCollections: [ProfileFavoriteCollection], collectionSymbolsAggregate: CollectionSymbolsAggregate) {
        self.init(unsafeResultMap: ["__typename": "app_collections", "name": name, "image_url": imageUrl, "id": id, "description": description, "profile_favorite_collections": profileFavoriteCollections.map { (value: ProfileFavoriteCollection) -> ResultMap in value.resultMap }, "collection_symbols_aggregate": collectionSymbolsAggregate.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      public var imageUrl: String {
        get {
          return resultMap["image_url"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image_url")
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

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      /// An array relationship
      public var profileFavoriteCollections: [ProfileFavoriteCollection] {
        get {
          return (resultMap["profile_favorite_collections"] as! [ResultMap]).map { (value: ResultMap) -> ProfileFavoriteCollection in ProfileFavoriteCollection(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: ProfileFavoriteCollection) -> ResultMap in value.resultMap }, forKey: "profile_favorite_collections")
        }
      }

      /// An aggregate relationship
      public var collectionSymbolsAggregate: CollectionSymbolsAggregate {
        get {
          return CollectionSymbolsAggregate(unsafeResultMap: resultMap["collection_symbols_aggregate"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "collection_symbols_aggregate")
        }
      }

      public struct ProfileFavoriteCollection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_profile_favorite_collections"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("profile_id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("collection_id", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(profileId: Int, collectionId: Int) {
          self.init(unsafeResultMap: ["__typename": "app_profile_favorite_collections", "profile_id": profileId, "collection_id": collectionId])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var profileId: Int {
          get {
            return resultMap["profile_id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "profile_id")
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

      public struct CollectionSymbolsAggregate: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_collection_symbols_aggregate"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("aggregate", type: .object(Aggregate.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(aggregate: Aggregate? = nil) {
          self.init(unsafeResultMap: ["__typename": "app_collection_symbols_aggregate", "aggregate": aggregate.flatMap { (value: Aggregate) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var aggregate: Aggregate? {
          get {
            return (resultMap["aggregate"] as? ResultMap).flatMap { Aggregate(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "aggregate")
          }
        }

        public struct Aggregate: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["app_collection_symbols_aggregate_fields"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("count", type: .nonNull(.scalar(Int.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(count: Int) {
            self.init(unsafeResultMap: ["__typename": "app_collection_symbols_aggregate_fields", "count": count])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var count: Int {
            get {
              return resultMap["count"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "count")
            }
          }
        }
      }
    }
  }
}
