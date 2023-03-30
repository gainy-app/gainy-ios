// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPlaidProfileGainsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPlaidProfileGains($profileId: Int!) {
      portfolio_gains(where: {profile_id: {_eq: $profileId}}) {
        __typename
        ...PortoGains
      }
    }
    """

  public let operationName: String = "GetPlaidProfileGains"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + PortoGains.fragmentDefinition)
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
        GraphQLField("portfolio_gains", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileId")]]], type: .nonNull(.list(.nonNull(.object(PortfolioGain.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(portfolioGains: [PortfolioGain]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "portfolio_gains": portfolioGains.map { (value: PortfolioGain) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230329150441.portfolio_gains"
    public var portfolioGains: [PortfolioGain] {
      get {
        return (resultMap["portfolio_gains"] as! [ResultMap]).map { (value: ResultMap) -> PortfolioGain in PortfolioGain(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: PortfolioGain) -> ResultMap in value.resultMap }, forKey: "portfolio_gains")
      }
    }

    public struct PortfolioGain: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["portfolio_gains"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(PortoGains.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(absoluteGain_1d: float8? = nil, absoluteGain_1m: float8? = nil, absoluteGain_1w: float8? = nil, absoluteGain_1y: float8? = nil, absoluteGain_3m: float8? = nil, absoluteGain_5y: float8? = nil, absoluteGainTotal: float8? = nil, actualValue: float8? = nil, relativeGain_1d: float8? = nil, relativeGain_1m: float8? = nil, relativeGain_1w: float8? = nil, relativeGain_1y: float8? = nil, relativeGain_3m: float8? = nil, relativeGain_5y: float8? = nil, relativeGainTotal: float8? = nil) {
        self.init(unsafeResultMap: ["__typename": "portfolio_gains", "absolute_gain_1d": absoluteGain_1d, "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "actual_value": actualValue, "relative_gain_1d": relativeGain_1d, "relative_gain_1m": relativeGain_1m, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal])
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

        public var portoGains: PortoGains {
          get {
            return PortoGains(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}
