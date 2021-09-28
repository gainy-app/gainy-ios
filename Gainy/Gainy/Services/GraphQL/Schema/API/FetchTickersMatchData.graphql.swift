// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchTickersMatchDataQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchTickersMatchData($profileId: Int!, $collectionIds: [Int!]) {
      get_match_scores_by_collections(
        profile_id: $profileId
        collection_ids: $collectionIds
      ) {
        __typename
        is_match
        match_score
        symbol
        collection_id
      }
    }
    """

  public let operationName: String = "FetchTickersMatchData"

  public var profileId: Int
  public var collectionIds: [Int]?

  public init(profileId: Int, collectionIds: [Int]?) {
    self.profileId = profileId
    self.collectionIds = collectionIds
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "collectionIds": collectionIds]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("get_match_scores_by_collections", arguments: ["profile_id": GraphQLVariable("profileId"), "collection_ids": GraphQLVariable("collectionIds")], type: .list(.object(GetMatchScoresByCollection.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getMatchScoresByCollections: [GetMatchScoresByCollection?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "get_match_scores_by_collections": getMatchScoresByCollections.flatMap { (value: [GetMatchScoresByCollection?]) -> [ResultMap?] in value.map { (value: GetMatchScoresByCollection?) -> ResultMap? in value.flatMap { (value: GetMatchScoresByCollection) -> ResultMap in value.resultMap } } }])
    }

    public var getMatchScoresByCollections: [GetMatchScoresByCollection?]? {
      get {
        return (resultMap["get_match_scores_by_collections"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetMatchScoresByCollection?] in value.map { (value: ResultMap?) -> GetMatchScoresByCollection? in value.flatMap { (value: ResultMap) -> GetMatchScoresByCollection in GetMatchScoresByCollection(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetMatchScoresByCollection?]) -> [ResultMap?] in value.map { (value: GetMatchScoresByCollection?) -> ResultMap? in value.flatMap { (value: GetMatchScoresByCollection) -> ResultMap in value.resultMap } } }, forKey: "get_match_scores_by_collections")
      }
    }

    public struct GetMatchScoresByCollection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["MatchScore"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("is_match", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("match_score", type: .nonNull(.scalar(Int.self))),
          GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
          GraphQLField("collection_id", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(isMatch: Bool, matchScore: Int, symbol: String, collectionId: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "MatchScore", "is_match": isMatch, "match_score": matchScore, "symbol": symbol, "collection_id": collectionId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var isMatch: Bool {
        get {
          return resultMap["is_match"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "is_match")
        }
      }

      public var matchScore: Int {
        get {
          return resultMap["match_score"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "match_score")
        }
      }

      public var symbol: String {
        get {
          return resultMap["symbol"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "symbol")
        }
      }

      public var collectionId: String? {
        get {
          return resultMap["collection_id"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "collection_id")
        }
      }
    }
  }
}
