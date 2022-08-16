// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class SetRecommendationSettingsMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation set_recommendation_settings($profileId: Int!, $interests: [Int], $categories: [Int], $recommended_collections_count: Int) {
      set_recommendation_settings(
        profile_id: $profileId
        interests: $interests
        categories: $categories
        recommended_collections_count: $recommended_collections_count
      ) {
        __typename
        recommended_collections {
          __typename
          id
          collection {
            __typename
            id
            name
            image_url
            enabled
            description
          }
        }
      }
    }
    """

  public let operationName: String = "set_recommendation_settings"

  public var profileId: Int
  public var interests: [Int?]?
  public var categories: [Int?]?
  public var recommended_collections_count: Int?

  public init(profileId: Int, interests: [Int?]? = nil, categories: [Int?]? = nil, recommended_collections_count: Int? = nil) {
    self.profileId = profileId
    self.interests = interests
    self.categories = categories
    self.recommended_collections_count = recommended_collections_count
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "interests": interests, "categories": categories, "recommended_collections_count": recommended_collections_count]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("set_recommendation_settings", arguments: ["profile_id": GraphQLVariable("profileId"), "interests": GraphQLVariable("interests"), "categories": GraphQLVariable("categories"), "recommended_collections_count": GraphQLVariable("recommended_collections_count")], type: .object(SetRecommendationSetting.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(setRecommendationSettings: SetRecommendationSetting? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "set_recommendation_settings": setRecommendationSettings.flatMap { (value: SetRecommendationSetting) -> ResultMap in value.resultMap }])
    }

    public var setRecommendationSettings: SetRecommendationSetting? {
      get {
        return (resultMap["set_recommendation_settings"] as? ResultMap).flatMap { SetRecommendationSetting(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "set_recommendation_settings")
      }
    }

    public struct SetRecommendationSetting: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SetRecommendationSettingsOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("recommended_collections", type: .list(.object(RecommendedCollection.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(recommendedCollections: [RecommendedCollection?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "SetRecommendationSettingsOutput", "recommended_collections": recommendedCollections.flatMap { (value: [RecommendedCollection?]) -> [ResultMap?] in value.map { (value: RecommendedCollection?) -> ResultMap? in value.flatMap { (value: RecommendedCollection) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var recommendedCollections: [RecommendedCollection?]? {
        get {
          return (resultMap["recommended_collections"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [RecommendedCollection?] in value.map { (value: ResultMap?) -> RecommendedCollection? in value.flatMap { (value: ResultMap) -> RecommendedCollection in RecommendedCollection(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [RecommendedCollection?]) -> [ResultMap?] in value.map { (value: RecommendedCollection?) -> ResultMap? in value.flatMap { (value: RecommendedCollection) -> ResultMap in value.resultMap } } }, forKey: "recommended_collections")
        }
      }

      public struct RecommendedCollection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Collection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("collection", type: .object(Collection.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, collection: Collection? = nil) {
          self.init(unsafeResultMap: ["__typename": "Collection", "id": id, "collection": collection.flatMap { (value: Collection) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("image_url", type: .scalar(String.self)),
              GraphQLField("enabled", type: .scalar(String.self)),
              GraphQLField("description", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, name: String? = nil, imageUrl: String? = nil, enabled: String? = nil, description: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "collections", "id": id, "name": name, "image_url": imageUrl, "enabled": enabled, "description": description])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
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

          public var imageUrl: String? {
            get {
              return resultMap["image_url"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "image_url")
            }
          }

          public var enabled: String? {
            get {
              return resultMap["enabled"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "enabled")
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
        }
      }
    }
  }
}
