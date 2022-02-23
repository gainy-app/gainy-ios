// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchHomeDataQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchHomeData($profileID: Int!) {
      profile_collection_tickers_performance_ranked(
        where: {profile_id: {_eq: $profileID}}
      ) {
        __typename
        gainer_rank
        loser_rank
        profile_id
        relative_daily_change
        symbol
        updated_at
      }
      app_profile_favorite_collections(where: {profile_id: {_eq: $profileID}}) {
        __typename
        collection {
          __typename
          name
          size
          metrics {
            __typename
            absolute_daily_change
            relative_daily_change
            updated_at
          }
        }
      }
    }
    """

  public let operationName: String = "FetchHomeData"

  public var profileID: Int

  public init(profileID: Int) {
    self.profileID = profileID
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("profile_collection_tickers_performance_ranked", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileID")]]], type: .nonNull(.list(.nonNull(.object(ProfileCollectionTickersPerformanceRanked.selections))))),
        GraphQLField("app_profile_favorite_collections", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileID")]]], type: .nonNull(.list(.nonNull(.object(AppProfileFavoriteCollection.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(profileCollectionTickersPerformanceRanked: [ProfileCollectionTickersPerformanceRanked], appProfileFavoriteCollections: [AppProfileFavoriteCollection]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "profile_collection_tickers_performance_ranked": profileCollectionTickersPerformanceRanked.map { (value: ProfileCollectionTickersPerformanceRanked) -> ResultMap in value.resultMap }, "app_profile_favorite_collections": appProfileFavoriteCollections.map { (value: AppProfileFavoriteCollection) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_220217172253.profile_collection_tickers_performance_ranked"
    public var profileCollectionTickersPerformanceRanked: [ProfileCollectionTickersPerformanceRanked] {
      get {
        return (resultMap["profile_collection_tickers_performance_ranked"] as! [ResultMap]).map { (value: ResultMap) -> ProfileCollectionTickersPerformanceRanked in ProfileCollectionTickersPerformanceRanked(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: ProfileCollectionTickersPerformanceRanked) -> ResultMap in value.resultMap }, forKey: "profile_collection_tickers_performance_ranked")
      }
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

    public struct ProfileCollectionTickersPerformanceRanked: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["profile_collection_tickers_performance_ranked"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("gainer_rank", type: .scalar(Int.self)),
          GraphQLField("loser_rank", type: .scalar(Int.self)),
          GraphQLField("profile_id", type: .scalar(Int.self)),
          GraphQLField("relative_daily_change", type: .scalar(float8.self)),
          GraphQLField("symbol", type: .scalar(String.self)),
          GraphQLField("updated_at", type: .scalar(timestamp.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(gainerRank: Int? = nil, loserRank: Int? = nil, profileId: Int? = nil, relativeDailyChange: float8? = nil, symbol: String? = nil, updatedAt: timestamp? = nil) {
        self.init(unsafeResultMap: ["__typename": "profile_collection_tickers_performance_ranked", "gainer_rank": gainerRank, "loser_rank": loserRank, "profile_id": profileId, "relative_daily_change": relativeDailyChange, "symbol": symbol, "updated_at": updatedAt])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var gainerRank: Int? {
        get {
          return resultMap["gainer_rank"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "gainer_rank")
        }
      }

      public var loserRank: Int? {
        get {
          return resultMap["loser_rank"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "loser_rank")
        }
      }

      public var profileId: Int? {
        get {
          return resultMap["profile_id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "profile_id")
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

      public var symbol: String? {
        get {
          return resultMap["symbol"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "symbol")
        }
      }

      public var updatedAt: timestamp? {
        get {
          return resultMap["updated_at"] as? timestamp
        }
        set {
          resultMap.updateValue(newValue, forKey: "updated_at")
        }
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
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("size", type: .scalar(Int.self)),
            GraphQLField("metrics", type: .object(Metric.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, size: Int? = nil, metrics: Metric? = nil) {
          self.init(unsafeResultMap: ["__typename": "collections", "name": name, "size": size, "metrics": metrics.flatMap { (value: Metric) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public struct Metric: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["collection_metrics"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("absolute_daily_change", type: .scalar(float8.self)),
              GraphQLField("relative_daily_change", type: .scalar(float8.self)),
              GraphQLField("updated_at", type: .scalar(timestamp.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(absoluteDailyChange: float8? = nil, relativeDailyChange: float8? = nil, updatedAt: timestamp? = nil) {
            self.init(unsafeResultMap: ["__typename": "collection_metrics", "absolute_daily_change": absoluteDailyChange, "relative_daily_change": relativeDailyChange, "updated_at": updatedAt])
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

          public var updatedAt: timestamp? {
            get {
              return resultMap["updated_at"] as? timestamp
            }
            set {
              resultMap.updateValue(newValue, forKey: "updated_at")
            }
          }
        }
      }
    }
  }
}
