// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchTickersMatchDataQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchTickersMatchData($profileId: Int!, $collectionId: Int!) {
      get_match_scores_by_collection(
        profile_id: $profileId
        collection_id: $collectionId
      ) {
        __typename
        is_match
        match_score
        symbol
        fits_risk
        fits_categories
        fits_interests
      }
    }
    """

  public let operationName: String = "FetchTickersMatchData"

  public var profileId: Int
  public var collectionId: Int

  public init(profileId: Int, collectionId: Int) {
    self.profileId = profileId
    self.collectionId = collectionId
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "collectionId": collectionId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("get_match_scores_by_collection", arguments: ["profile_id": GraphQLVariable("profileId"), "collection_id": GraphQLVariable("collectionId")], type: .list(.object(GetMatchScoresByCollection.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getMatchScoresByCollection: [GetMatchScoresByCollection?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "get_match_scores_by_collection": getMatchScoresByCollection.flatMap { (value: [GetMatchScoresByCollection?]) -> [ResultMap?] in value.map { (value: GetMatchScoresByCollection?) -> ResultMap? in value.flatMap { (value: GetMatchScoresByCollection) -> ResultMap in value.resultMap } } }])
    }

    public var getMatchScoresByCollection: [GetMatchScoresByCollection?]? {
      get {
        return (resultMap["get_match_scores_by_collection"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetMatchScoresByCollection?] in value.map { (value: ResultMap?) -> GetMatchScoresByCollection? in value.flatMap { (value: ResultMap) -> GetMatchScoresByCollection in GetMatchScoresByCollection(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetMatchScoresByCollection?]) -> [ResultMap?] in value.map { (value: GetMatchScoresByCollection?) -> ResultMap? in value.flatMap { (value: GetMatchScoresByCollection) -> ResultMap in value.resultMap } } }, forKey: "get_match_scores_by_collection")
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
          GraphQLField("fits_risk", type: .nonNull(.scalar(Int.self))),
          GraphQLField("fits_categories", type: .nonNull(.scalar(Int.self))),
          GraphQLField("fits_interests", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(isMatch: Bool, matchScore: Int, symbol: String, fitsRisk: Int, fitsCategories: Int, fitsInterests: Int) {
        self.init(unsafeResultMap: ["__typename": "MatchScore", "is_match": isMatch, "match_score": matchScore, "symbol": symbol, "fits_risk": fitsRisk, "fits_categories": fitsCategories, "fits_interests": fitsInterests])
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

      public var fitsRisk: Int {
        get {
          return resultMap["fits_risk"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "fits_risk")
        }
      }

      public var fitsCategories: Int {
        get {
          return resultMap["fits_categories"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "fits_categories")
        }
      }

      public var fitsInterests: Int {
        get {
          return resultMap["fits_interests"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "fits_interests")
        }
      }
    }
  }
}
