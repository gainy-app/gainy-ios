// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchRecommendedCollectionIDsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchRecommendedCollectionIDs($profileId: Int!, $forceReload: Boolean!) @cached(ttl: 300) {
      get_recommended_collections(
        profile_id: $profileId
        force: $forceReload
        limit: 70
      ) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "FetchRecommendedCollectionIDs"

  public var profileId: Int
  public var forceReload: Bool

  public init(profileId: Int, forceReload: Bool) {
    self.profileId = profileId
    self.forceReload = forceReload
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "forceReload": forceReload]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("get_recommended_collections", arguments: ["profile_id": GraphQLVariable("profileId"), "force": GraphQLVariable("forceReload"), "limit": 70], type: .list(.object(GetRecommendedCollection.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getRecommendedCollections: [GetRecommendedCollection?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "get_recommended_collections": getRecommendedCollections.flatMap { (value: [GetRecommendedCollection?]) -> [ResultMap?] in value.map { (value: GetRecommendedCollection?) -> ResultMap? in value.flatMap { (value: GetRecommendedCollection) -> ResultMap in value.resultMap } } }])
    }

    public var getRecommendedCollections: [GetRecommendedCollection?]? {
      get {
        return (resultMap["get_recommended_collections"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetRecommendedCollection?] in value.map { (value: ResultMap?) -> GetRecommendedCollection? in value.flatMap { (value: ResultMap) -> GetRecommendedCollection in GetRecommendedCollection(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetRecommendedCollection?]) -> [ResultMap?] in value.map { (value: GetRecommendedCollection?) -> ResultMap? in value.flatMap { (value: GetRecommendedCollection) -> ResultMap in value.resultMap } } }, forKey: "get_recommended_collections")
      }
    }

    public struct GetRecommendedCollection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Collection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int) {
        self.init(unsafeResultMap: ["__typename": "Collection", "id": id])
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
    }
  }
}
