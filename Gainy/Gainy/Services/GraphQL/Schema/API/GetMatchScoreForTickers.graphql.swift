// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetMatchScoreForTickersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetMatchScoreForTickers($profileId: Int!, $symbols: [String!]) {
      get_match_scores_by_ticker_list(profile_id: $profileId, symbols: $symbols) {
        __typename
        ...LiveMatch
      }
    }
    """

  public let operationName: String = "GetMatchScoreForTickers"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + LiveMatch.fragmentDefinition)
    return document
  }

  public var profileId: Int
  public var symbols: [String]?

  public init(profileId: Int, symbols: [String]?) {
    self.profileId = profileId
    self.symbols = symbols
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "symbols": symbols]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("get_match_scores_by_ticker_list", arguments: ["profile_id": GraphQLVariable("profileId"), "symbols": GraphQLVariable("symbols")], type: .list(.object(GetMatchScoresByTickerList.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getMatchScoresByTickerList: [GetMatchScoresByTickerList?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "get_match_scores_by_ticker_list": getMatchScoresByTickerList.flatMap { (value: [GetMatchScoresByTickerList?]) -> [ResultMap?] in value.map { (value: GetMatchScoresByTickerList?) -> ResultMap? in value.flatMap { (value: GetMatchScoresByTickerList) -> ResultMap in value.resultMap } } }])
    }

    public var getMatchScoresByTickerList: [GetMatchScoresByTickerList?]? {
      get {
        return (resultMap["get_match_scores_by_ticker_list"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetMatchScoresByTickerList?] in value.map { (value: ResultMap?) -> GetMatchScoresByTickerList? in value.flatMap { (value: ResultMap) -> GetMatchScoresByTickerList in GetMatchScoresByTickerList(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetMatchScoresByTickerList?]) -> [ResultMap?] in value.map { (value: GetMatchScoresByTickerList?) -> ResultMap? in value.flatMap { (value: GetMatchScoresByTickerList) -> ResultMap in value.resultMap } } }, forKey: "get_match_scores_by_ticker_list")
      }
    }

    public struct GetMatchScoresByTickerList: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["MatchScore"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(LiveMatch.self),
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

        public var liveMatch: LiveMatch {
          get {
            return LiveMatch(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}
