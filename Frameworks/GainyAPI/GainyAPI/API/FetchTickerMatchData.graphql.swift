// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchTickerMatchDataQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchTickerMatchData($profielId: Int!, $symbol: String!) {
      get_match_score_by_ticker(profile_id: $profielId, symbol: $symbol) {
        __typename
        ...LiveMatch
      }
    }
    """

  public let operationName: String = "FetchTickerMatchData"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + LiveMatch.fragmentDefinition)
    return document
  }

  public var profielId: Int
  public var symbol: String

  public init(profielId: Int, symbol: String) {
    self.profielId = profielId
    self.symbol = symbol
  }

  public var variables: GraphQLMap? {
    return ["profielId": profielId, "symbol": symbol]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("get_match_score_by_ticker", arguments: ["profile_id": GraphQLVariable("profielId"), "symbol": GraphQLVariable("symbol")], type: .object(GetMatchScoreByTicker.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getMatchScoreByTicker: GetMatchScoreByTicker? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "get_match_score_by_ticker": getMatchScoreByTicker.flatMap { (value: GetMatchScoreByTicker) -> ResultMap in value.resultMap }])
    }

    public var getMatchScoreByTicker: GetMatchScoreByTicker? {
      get {
        return (resultMap["get_match_score_by_ticker"] as? ResultMap).flatMap { GetMatchScoreByTicker(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "get_match_score_by_ticker")
      }
    }

    public struct GetMatchScoreByTicker: GraphQLSelectionSet {
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

      public init(isMatch: Bool, matchScore: Int, symbol: String, fitsRisk: Int, fitsCategories: Int, fitsInterests: Int, riskSimilarity: Double, interestMatches: String? = nil, categoryMatches: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "MatchScore", "is_match": isMatch, "match_score": matchScore, "symbol": symbol, "fits_risk": fitsRisk, "fits_categories": fitsCategories, "fits_interests": fitsInterests, "risk_similarity": riskSimilarity, "interest_matches": interestMatches, "category_matches": categoryMatches])
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
