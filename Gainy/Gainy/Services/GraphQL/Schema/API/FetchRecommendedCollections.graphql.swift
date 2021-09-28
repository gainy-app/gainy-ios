// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchRecommendedCollectionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchRecommendedCollections($profileId: Int!) {
      get_recommended_collections(profile_id: $profileId) {
        __typename
        id
        collection {
          __typename
          ...RemoteCollectionDetails
        }
      }
    }
    """

  public let operationName: String = "FetchRecommendedCollections"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RemoteCollectionDetails.fragmentDefinition)
    document.append("\n" + RemoteTickerDetails.fragmentDefinition)
    return document
  }

  public var profileId: Int

  public init(profileId: Int) {
    self.profileId = profileId
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("get_recommended_collections", arguments: ["profile_id": GraphQLVariable("profileId")], type: .list(.object(GetRecommendedCollection.selections))),
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
      public static let possibleTypes: [String] = ["RecommendedCollection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("collection", type: .nonNull(.object(Collection.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, collection: Collection) {
        self.init(unsafeResultMap: ["__typename": "RecommendedCollection", "id": id, "collection": collection.resultMap])
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

      /// An object relationship
      public var collection: Collection {
        get {
          return Collection(unsafeResultMap: resultMap["collection"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "collection")
        }
      }

      public struct Collection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["collections"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RemoteCollectionDetails.self),
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

          public var remoteCollectionDetails: RemoteCollectionDetails {
            get {
              return RemoteCollectionDetails(unsafeResultMap: resultMap)
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
