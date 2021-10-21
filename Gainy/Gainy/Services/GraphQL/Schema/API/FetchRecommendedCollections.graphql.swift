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
          ...RemoteShortCollectionDetails
        }
      }
    }
    """

  public let operationName: String = "FetchRecommendedCollections"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RemoteShortCollectionDetails.fragmentDefinition)
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

public struct RemoteShortCollectionDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment RemoteShortCollectionDetails on collections {
      __typename
      id
      name
      image_url
      enabled
      description
      ticker_collections_aggregate {
        __typename
        aggregate {
          __typename
          count
        }
      }
    }
    """

  public static let possibleTypes: [String] = ["collections"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .scalar(Int.self)),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("image_url", type: .scalar(String.self)),
      GraphQLField("enabled", type: .scalar(String.self)),
      GraphQLField("description", type: .scalar(String.self)),
      GraphQLField("ticker_collections_aggregate", type: .nonNull(.object(TickerCollectionsAggregate.selections))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: Int? = nil, name: String? = nil, imageUrl: String? = nil, enabled: String? = nil, description: String? = nil, tickerCollectionsAggregate: TickerCollectionsAggregate) {
    self.init(unsafeResultMap: ["__typename": "collections", "id": id, "name": name, "image_url": imageUrl, "enabled": enabled, "description": description, "ticker_collections_aggregate": tickerCollectionsAggregate.resultMap])
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

  /// An aggregate relationship
  public var tickerCollectionsAggregate: TickerCollectionsAggregate {
    get {
      return TickerCollectionsAggregate(unsafeResultMap: resultMap["ticker_collections_aggregate"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "ticker_collections_aggregate")
    }
  }

  public struct TickerCollectionsAggregate: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ticker_collections_aggregate"]

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
      self.init(unsafeResultMap: ["__typename": "ticker_collections_aggregate", "aggregate": aggregate.flatMap { (value: Aggregate) -> ResultMap in value.resultMap }])
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
      public static let possibleTypes: [String] = ["ticker_collections_aggregate_fields"]

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
        self.init(unsafeResultMap: ["__typename": "ticker_collections_aggregate_fields", "count": count])
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
