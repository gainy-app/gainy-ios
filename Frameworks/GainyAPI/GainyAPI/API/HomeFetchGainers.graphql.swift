// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class HomeFetchGainersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query HomeFetchGainers($profileId: Int!) {
      profile_collection_tickers_performance_ranked(
        where: {profile_id: {_eq: $profileId}}
      ) {
        __typename
        gainer_rank
        loser_rank
        profile_id
        relative_daily_change
        symbol
        updated_at
      }
    }
    """

  public let operationName: String = "HomeFetchGainers"

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
        GraphQLField("profile_collection_tickers_performance_ranked", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileId")]]], type: .nonNull(.list(.nonNull(.object(ProfileCollectionTickersPerformanceRanked.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(profileCollectionTickersPerformanceRanked: [ProfileCollectionTickersPerformanceRanked]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "profile_collection_tickers_performance_ranked": profileCollectionTickersPerformanceRanked.map { (value: ProfileCollectionTickersPerformanceRanked) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_220908173310.profile_collection_tickers_performance_ranked"
    public var profileCollectionTickersPerformanceRanked: [ProfileCollectionTickersPerformanceRanked] {
      get {
        return (resultMap["profile_collection_tickers_performance_ranked"] as! [ResultMap]).map { (value: ResultMap) -> ProfileCollectionTickersPerformanceRanked in ProfileCollectionTickersPerformanceRanked(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: ProfileCollectionTickersPerformanceRanked) -> ResultMap in value.resultMap }, forKey: "profile_collection_tickers_performance_ranked")
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
  }
}
