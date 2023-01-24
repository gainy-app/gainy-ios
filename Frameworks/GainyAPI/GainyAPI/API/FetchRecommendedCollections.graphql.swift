// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchRecommendedCollectionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchRecommendedCollections($profileId: Int!, $forceReload: Boolean!) @cached(ttl: 300) {
      get_recommended_collections(profile_id: $profileId, force: $forceReload) {
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
        GraphQLField("get_recommended_collections", arguments: ["profile_id": GraphQLVariable("profileId"), "force": GraphQLVariable("forceReload")], type: .list(.object(GetRecommendedCollection.selections))),
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
      size
      metrics {
        __typename
        absolute_daily_change
        relative_daily_change
        value_change_1w
        value_change_1m
        value_change_3m
        value_change_1y
        value_change_5y
        updated_at
        clicks_rank
        performance_rank
      }
      match_score {
        __typename
        match_score
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
      GraphQLField("size", type: .scalar(Int.self)),
      GraphQLField("metrics", type: .object(Metric.selections)),
      GraphQLField("match_score", type: .object(MatchScore.selections)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: Int? = nil, name: String? = nil, imageUrl: String? = nil, enabled: String? = nil, description: String? = nil, size: Int? = nil, metrics: Metric? = nil, matchScore: MatchScore? = nil) {
    self.init(unsafeResultMap: ["__typename": "collections", "id": id, "name": name, "image_url": imageUrl, "enabled": enabled, "description": description, "size": size, "metrics": metrics.flatMap { (value: Metric) -> ResultMap in value.resultMap }, "match_score": matchScore.flatMap { (value: MatchScore) -> ResultMap in value.resultMap }])
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

  public var size: Int? {
    get {
      return resultMap["size"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "size")
    }
  }

  /// An object relationship
  public var metrics: Metric? {
    get {
      return (resultMap["metrics"] as? ResultMap).flatMap { Metric(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "metrics")
    }
  }

  /// An object relationship
  public var matchScore: MatchScore? {
    get {
      return (resultMap["match_score"] as? ResultMap).flatMap { MatchScore(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "match_score")
    }
  }

  public struct Metric: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["collection_metrics"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("absolute_daily_change", type: .scalar(float8.self)),
        GraphQLField("relative_daily_change", type: .scalar(float8.self)),
        GraphQLField("value_change_1w", type: .scalar(numeric.self)),
        GraphQLField("value_change_1m", type: .scalar(numeric.self)),
        GraphQLField("value_change_3m", type: .scalar(numeric.self)),
        GraphQLField("value_change_1y", type: .scalar(numeric.self)),
        GraphQLField("value_change_5y", type: .scalar(numeric.self)),
        GraphQLField("updated_at", type: .scalar(timestamptz.self)),
        GraphQLField("clicks_rank", type: .scalar(Int.self)),
        GraphQLField("performance_rank", type: .scalar(Int.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(absoluteDailyChange: float8? = nil, relativeDailyChange: float8? = nil, valueChange_1w: numeric? = nil, valueChange_1m: numeric? = nil, valueChange_3m: numeric? = nil, valueChange_1y: numeric? = nil, valueChange_5y: numeric? = nil, updatedAt: timestamptz? = nil, clicksRank: Int? = nil, performanceRank: Int? = nil) {
      self.init(unsafeResultMap: ["__typename": "collection_metrics", "absolute_daily_change": absoluteDailyChange, "relative_daily_change": relativeDailyChange, "value_change_1w": valueChange_1w, "value_change_1m": valueChange_1m, "value_change_3m": valueChange_3m, "value_change_1y": valueChange_1y, "value_change_5y": valueChange_5y, "updated_at": updatedAt, "clicks_rank": clicksRank, "performance_rank": performanceRank])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var absoluteDailyChange: float8? {
      get {
        return resultMap["absolute_daily_change"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "absolute_daily_change")
      }
    }

    public var relativeDailyChange: float8? {
      get {
        return resultMap["relative_daily_change"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "relative_daily_change")
      }
    }

    public var valueChange_1w: numeric? {
      get {
        return resultMap["value_change_1w"] as? numeric
      }
      set {
        resultMap.updateValue(newValue, forKey: "value_change_1w")
      }
    }

    public var valueChange_1m: numeric? {
      get {
        return resultMap["value_change_1m"] as? numeric
      }
      set {
        resultMap.updateValue(newValue, forKey: "value_change_1m")
      }
    }

    public var valueChange_3m: numeric? {
      get {
        return resultMap["value_change_3m"] as? numeric
      }
      set {
        resultMap.updateValue(newValue, forKey: "value_change_3m")
      }
    }

    public var valueChange_1y: numeric? {
      get {
        return resultMap["value_change_1y"] as? numeric
      }
      set {
        resultMap.updateValue(newValue, forKey: "value_change_1y")
      }
    }

    public var valueChange_5y: numeric? {
      get {
        return resultMap["value_change_5y"] as? numeric
      }
      set {
        resultMap.updateValue(newValue, forKey: "value_change_5y")
      }
    }

    public var updatedAt: timestamptz? {
      get {
        return resultMap["updated_at"] as? timestamptz
      }
      set {
        resultMap.updateValue(newValue, forKey: "updated_at")
      }
    }

    public var clicksRank: Int? {
      get {
        return resultMap["clicks_rank"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "clicks_rank")
      }
    }

    public var performanceRank: Int? {
      get {
        return resultMap["performance_rank"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "performance_rank")
      }
    }
  }

  public struct MatchScore: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["collection_match_score"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("match_score", type: .scalar(float8.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(matchScore: float8? = nil) {
      self.init(unsafeResultMap: ["__typename": "collection_match_score", "match_score": matchScore])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var matchScore: float8? {
      get {
        return resultMap["match_score"] as? float8
      }
      set {
        resultMap.updateValue(newValue, forKey: "match_score")
      }
    }
  }
}
